//
//  HomeService.swift
//  StackOverFlowClient
//
//  Created by Mariganesh on 11/01/20.
//  Copyright © 2020 Tart Labs. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

public class HomeService {
    
    public static func getAllQuestions(currentPage:Int,sortType:SortType,view:QuestionsProtocol){
        
        let url:String = HttpUrl.getAllQuestionsUrl()
        
        var parameter:[String:Any] = [:]
        
        parameter["site"] = "stackoverflow"
        parameter["order"] = "desc"
        parameter["page"] = currentPage
        parameter["pagesize"] = 10
        parameter["sort"] = sortType.toString()
        
        Alamofire.request(url,
                          method: .get,
                          parameters: parameter,
                          encoding: URLEncoding.default)
            .responseObject { (response:DataResponse<QuestionListResponse>) in
                
                guard let questionResponse = response.result.value else {
                    return view.onAllQuestionFailure(message: "Something went wrong")
                }
                
                let statusCode = response.response?.statusCode
                
                switch statusCode{
                case 200:
                    view.onAllQuestionSuccess(questions:questionResponse.getAllQuestions())
                    break
                default:
                    return view.onAllQuestionFailure(message: "Something went wrong")
                }
        }
    }
    
    public static func getTagquestions(currentPage:Int,tag:String,view:QuestionsProtocol){
        
        let url:String = HttpUrl.getTagquestionsUrl(tag: tag)
        
        var parameter:[String:Any] = [:]
        
        parameter["site"] = "stackoverflow"
        parameter["filter"] = "default"
        parameter["page"] = currentPage
        parameter["pagesize"] = 10
        
        Alamofire.request(url,
                          method: .get,
                          parameters: parameter,
                          encoding: URLEncoding.default)
            .responseObject { (response:DataResponse<QuestionListResponse>) in
                
                guard let questionResponse = response.result.value else {
                    return view.onAllQuestionFailure(message: "Something went wrong")
                }
                
                let statusCode = response.response?.statusCode
                
                switch statusCode{
                case 200:
                    view.onAllQuestionSuccess(questions:questionResponse.getAllQuestions())
                    break
                default:
                    return view.onAllQuestionFailure(message: "Something went wrong")
                }
        }
    }
    
}

public protocol QuestionsProtocol{
    func onAllQuestionSuccess(questions:[Question])
    func onAllQuestionFailure(message:String)
}
