//
//  Theme.swift
//  concentration
//
//  Created by Sander Teunissen on 12-09-18.
//  Copyright © 2018 Sander Teunissen. All rights reserved.
//

import UIKit

struct Theme {
    let name: String
    let statusBarTheme: UIStatusBarStyle
    let background: UIColor
    let cardColor: UIColor
    let fontColor: UIColor
    var emojis: String
}

extension UIColor {
    static let AppleBlue = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
    static let ChristmasRed = UIColor(red:0.59, green:0.00, blue:0.01, alpha:1.0)
    static let ChristmasGreen = UIColor(red:0.05, green:0.44, blue:0.01, alpha:1.0)
}
