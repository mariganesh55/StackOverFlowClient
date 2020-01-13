//
//  Fonts.swift
//  StackOverFlowClient
//
//  Created by Mariganesh on 03/01/20.
//  Copyright © 2020 Tart Labs. All rights reserved.
//

import Foundation

public enum Fonts:String {
    
    case GoogleSansItalic = "GoogleSans-Italic"
    case GoogleSansBold = "GoogleSans-Bold"
    case GoogleSansBoldItalic = "GoogleSans-BoldItalic"
    case GoogleSansRegular = "GoogleSans-Regular"
    case GoogleSansMediumItalic = "GoogleSans-MediumItalic"
    case GoogleSansMedium = "GoogleSans-Medium"
    
    public func toString()-> String{
        return self.rawValue
    }
}
