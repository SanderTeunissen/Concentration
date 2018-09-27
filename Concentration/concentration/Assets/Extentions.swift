//
//  Extentions.swift
//  concentration
//
//  Created by Sander Teunissen on 21-09-18.
//  Copyright © 2018 Sander Teunissen. All rights reserved.
//

import Foundation

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
    
    var none: Bool {
        return count == 0 ? true : false
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self))) }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
