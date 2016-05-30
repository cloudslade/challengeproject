//
//  AppearanceController.swift
//  ChallengeProject
//
//  Created by Dylan Slade on 5/28/16.
//  Copyright © 2016 Dylan Slade. All rights reserved.
//

import UIKit

class AppearanceController {
    static func configureAppearance() {
        UINavigationBar.appearance().barTintColor = UIColor.queGreen()
    }
}

extension UIColor {
    static func queGreen() -> UIColor {
        return UIColor(colorLiteralRed: 0.592, green: 0.780, blue: 0.631, alpha: 1.00)
    }
    
    static func queGray() -> UIColor {
        return UIColor(colorLiteralRed: 0.861, green: 0.861, blue: 0.861, alpha: 1.00)
    }
    
}