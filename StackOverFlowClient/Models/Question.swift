//
//  Question.swift
//  StackOverFlowClient
//
//  Created by Mariganesh on 11/01/20.
//  Copyright © 2020 Tart Labs. All rights reserved.
//

import Foundation
import ObjectMapper

public class Question:NSObject, Mappable {
    
    private var tags:[String] = []
    private var owner:Owner!
    private var isAnswered:Bool!
    private var viewCount:Int!
    private var answerCount:Int!
    private var score:Int!
    private var lastActivityDate:Date!
    private var creationDate:Date!
    private var questionId:Int!
    private var link:String!
    private var title:String!
    
    private var timeStamp:Int64!
    
    public required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        tags <- map["tags"]
        owner <- map["owner"]
        isAnswered <- map["is_answered"]
        viewCount <- map["view_count"]
        answerCount <- map["answer_count"]
        score <- map["score"]
        
        var activityDate:Int64!
        activityDate <- map["last_activity_date"]
        lastActivityDate = Date(milliseconds: activityDate)
        
        var createDate:Int64!
        createDate <- map["creation_date"]
        self.timeStamp = createDate
        creationDate = Date(milliseconds: createDate)
        
        questionId <- map["question_id"]
        link <- map["link"]
        title <- map["title"]
    }
    
    public func getVoteCount() -> Int{
        return self.score
    }
    
    public func getTitle() -> String{
        return self.title
    }
    
    public func getTags() -> [String]{
        return self.tags
    }
    
    public func getTimeStamp() -> String{
        return "\(self.timeStamp ?? 0)"
    }
    
    public func getDisplayName() ->String{
        return self.owner.getDisplayName()
    }
}
