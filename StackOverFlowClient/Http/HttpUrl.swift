//
//  HttpUrl.swift
//  StackOverFlowClient
//
//  Created by Mariganesh on 11/01/20.
//  Copyright © 2020 Tart Labs. All rights reserved.
//

import Foundation

class HttpUrl {
    
    public static func getAllQuestionsUrl() -> String{
        return "https://api.stackexchange.com/2.2/questions"
    }
    
    public static func getTagquestionsUrl(tag:String) -> String{
        return "https://api.stackexchange.com/2.2/tags/\(tag)/faq"
    }
}
