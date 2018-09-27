//
//  ThemeManager.swift
//  concentration
//
//  Created by Sander Teunissen on 21-09-18.
//  Copyright © 2018 Sander Teunissen. All rights reserved.
//

import Foundation

class ThemeManager{
    private static var currentThemePos = 0;
    
    private static let themes = [
        Theme(name: "Halloween", statusBarTheme: .lightContent, background: .black, cardColor: .orange, fontColor: .orange, emojis: "🦇😱🙀😈🎃👻🍭🍬🍎🧛‍♂️"),
        Theme(name: "Animals", statusBarTheme: .default, background: .white, cardColor: .green, fontColor: .AppleBlue, emojis: "🐶🐱🐭🐹🐰🦊🐮🦁🐯🐨🐼🐻🐷🐸🐵🐥"),
        Theme(name: "Food", statusBarTheme: .default, background: .white, cardColor: .green, fontColor: .AppleBlue, emojis: "🥨🌭🍔🍟🍕🥪🥗🍲🍙🍣🥙🥐🍿🍩"),
        Theme(name: "Christmas", statusBarTheme: .lightContent, background: .ChristmasRed, cardColor: .ChristmasGreen, fontColor: .white, emojis: "🎄🤶🏻🎅🏻🧦🧝🏻‍♀️🧝🏻‍♂️🎁⛄️🌟🕯🦌🍪🥛"),
        Theme(name: "Flags", statusBarTheme: .default, background: .white, cardColor: .AppleBlue, fontColor: .AppleBlue, emojis: "🇳🇱🇧🇪🇦🇷🇮🇹🇦🇪🏴󠁧󠁢󠁥󠁮󠁧󠁿🇬🇧🇪🇸🇺🇸🇷🇺🇨🇦🇩🇪🇪🇺🇧🇷🇩🇰🇫🇷🇨🇮"),
        Theme(name: "Faces", statusBarTheme: .default, background: .white, cardColor: .AppleBlue, fontColor: .AppleBlue, emojis: "😀😌😎🤓😠😤😭😰😱😳😜😇😊🤯🤥"),
        Theme(name: "Sport", statusBarTheme: .default, background: .white, cardColor: .AppleBlue, fontColor: .AppleBlue, emojis: "⚽️🏀🏈⚾️🎾🏐🏉🎱🏓🏸🏒🏏🏑⛸🚴‍♂️🚣‍♂️🏄‍♂️🏌️‍♀️🥋"),
    ]
    
    static var currentTheme: Theme {
        get{
            return themes[currentThemePos]
        }
    }
    
    static func getRandomTheme() -> Theme {
        currentThemePos = themes.count.arc4random
        return currentTheme
    }
}
