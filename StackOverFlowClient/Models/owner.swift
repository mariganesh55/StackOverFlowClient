//
//  owner.swift
//  StackOverFlowClient
//
//  Created by Mariganesh on 11/01/20.
//  Copyright © 2020 Tart Labs. All rights reserved.
//

import Foundation
import ObjectMapper

public class Owner:NSObject,Mappable {
   
    private var reputation:Int!
    private var userId:Int!
    private var userType:String!
    private var acceptRate:Int!
    private var profileImage:String!
    private var displayName:String!
    private var link:String!
    
    public required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        reputation <- map["reputation"]
        userId <- map["user_id"]
        userType <- map["user_type"]
        acceptRate <- map["accept_rate"]
        profileImage <- map["profile_image"]
        displayName <- map["display_name"]
        link <- map["link"]
    }
    
    public func getReputation() ->Int {
        return self.reputation
    }
    public func getUserId() ->Int {
        return self.userId
    }
    public func getAcceptRate() ->Int {
        return self.acceptRate
    }
    public func getUserType() ->String {
        return self.userType
    }
    public func getProfileImage() ->String {
        return self.profileImage
    }
    public func getDisplayName() ->String {
        return self.displayName
    }
    public func getLink() ->String {
        return self.link
    }
}
