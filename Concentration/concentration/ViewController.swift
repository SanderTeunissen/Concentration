//
//  ViewController.swift
//  concentration
//
//  Created by Sander Teunissen on 06-09-18.
//  Copyright © 2018 Sander Teunissen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ConcentrationDelgate {

    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    private var theme = ThemeManager.getRandomTheme()
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet weak var newGameButton: UIButton!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("choosen card was not in cardButtons")
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return theme.statusBarTheme
    }
    
    @IBAction private func newGameClick(_ sender: UIButton) {
        let confirmCheck = UIAlertController(title: "Confirm", message: "Are you sure you want to stop this game?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
            self.startNewGame()
        })
        let cancel = UIAlertAction(title: "No", style: .cancel)
        confirmCheck.addAction(ok)
        confirmCheck.addAction(cancel)
        self.present(confirmCheck, animated: true, completion: nil)
    }
    
    private func startNewGame(){
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        theme = ThemeManager.getRandomTheme()
        game.delegate = self
        change(score: 0)
        change(nrOfFlips: 0)
        updateViewFromModel()
        applyTheme()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game.delegate = self
        applyTheme()
    }
    
    private var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    func change(nrOfFlips: Int) {
        flipCountLabel.text = "Flips: \(nrOfFlips)"
    }
    
    func change(score: Int){
        scoreLabel.text = "Score: \(score)"
    }
    
    func gameOver(nrOfFlips: Int, score: Int){
        let newGame = UIAlertController(title: "Game Over", message: "You've completed the game in \(nrOfFlips) flips and scored \(score) points", preferredStyle: .alert)
        let new = UIAlertAction(title: "New game", style: .default, handler: { (action) -> Void in
            self.startNewGame()
        })
        newGame.addAction(new)
        self.present(newGame, animated: true, completion: nil)
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.titleLabel?.adjustsFontForContentSizeCategory = true
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                button.isEnabled = false;
            } else {
                button.setTitle("", for: .normal)
                if card.isMatched{
                    button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
                    button.isEnabled =  false;
                }else{
                    button.backgroundColor = theme.cardColor
                    button.isEnabled =  true;
                }
            }
        }
        
    }
    
    private var emoji = [Card: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, theme.emojis.count > 0 {
            let stringIndex = theme.emojis.index(theme.emojis.startIndex, offsetBy: theme.emojis.count.arc4random)
            emoji[card] = String(theme.emojis.remove(at: stringIndex))
        }
        return emoji[card] ?? "?"
    }
    
    private func applyTheme(){
        view.backgroundColor = theme.background
        flipCountLabel.textColor = theme.fontColor
        scoreLabel.textColor = theme.fontColor
        newGameButton.setTitleColor(theme.fontColor, for: .normal)
        setNeedsStatusBarAppearanceUpdate()
        for btn in cardButtons{
            btn.backgroundColor = theme.cardColor
            btn.titleLabel?.numberOfLines = 1
            btn.titleLabel?.adjustsFontSizeToFitWidth = true;
        }
    }
    
}
