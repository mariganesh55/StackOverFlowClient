//
//  Enum.swift
//  StackOverFlowClient
//
//  Created by Mariganesh on 11/01/20.
//  Copyright © 2020 Tart Labs. All rights reserved.
//

import Foundation

public enum SortType:String {
    
    case Activity = "activity"
    case Hot = "hot"
    case Votes = "votes"
    case Creation = "creation"
    
    public func toString()-> String{
        return self.rawValue
    }
}
