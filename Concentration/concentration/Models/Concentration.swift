//
//  Concentration.swift
//  concentration
//
//  Created by Sander Teunissen on 10-09-18.
//  Copyright © 2018 Sander Teunissen. All rights reserved.
//

import Foundation

class Concentration {
    weak var delegate: ConcentrationDelgate?
    var cards = [Card]()
    
    private var viewedCardIndexes = Array<Int>()
    
    private(set) var flipCount = 0 {
        didSet {
            if delegate != nil {
                delegate?.change(nrOfFlips: flipCount)
            }
        }
    }
    
    private(set) var score = 0 {
        didSet {
            if delegate != nil {
                delegate?.change(score: flipCount)
            }
        }
    }
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    var allCardsMatched: Bool {
        get{
            return cards.indices.filter { !cards[$0].isMatched }.none
        }
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)) : Choosen index out of range")
        if !cards[index].isMatched {
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    if viewedCardIndexes.contains(index) {
                        score -= 1
                    }
                    if viewedCardIndexes.contains(matchIndex) {
                        score -= 1
                    }
                }
                if !viewedCardIndexes.contains(index) {
                    viewedCardIndexes.append(index)
                }
                if !viewedCardIndexes.contains(matchIndex) {
                    viewedCardIndexes.append(matchIndex)
                }
                cards[index].isFaceUp = true
                if allCardsMatched && delegate != nil{
                    delegate?.gameOver(nrOfFlips: flipCount, score: score)
                }
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)) : You must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}

protocol ConcentrationDelgate: class {
    func change(nrOfFlips: Int)
    func change(score: Int)
    func gameOver(nrOfFlips: Int, score: Int)
}
