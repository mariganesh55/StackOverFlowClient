//
//  Utils.swift
//  StackOverFlowClient
//
//  Created by Mariganesh on 03/01/20.
//  Copyright © 2020 Tart Labs. All rights reserved.
//

import Foundation
import UIKit
import AVKit

class Utils {
    
    public static func getFont(named:Fonts, fontSize:CGFloat = UIFont.labelFontSize) -> UIFont {
        guard let font = UIFont(name: named.toString(), size: fontSize) else {
            fatalError("Failed to load the \(named) font.")
        }
        return font
    }
}
