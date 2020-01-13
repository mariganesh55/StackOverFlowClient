//
//  QuestionListResponse.swift
//  StackOverFlowClient
//
//  Created by Mariganesh on 11/01/20.
//  Copyright © 2020 Tart Labs. All rights reserved.
//

import Foundation
import ObjectMapper

public class QuestionListResponse:Mappable {
    
    private var questions:[Question] = []
    
    public required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        questions <- map["items"]
    }
    
    public func getAllQuestions() -> [Question]{
        return self.questions
    }
}
