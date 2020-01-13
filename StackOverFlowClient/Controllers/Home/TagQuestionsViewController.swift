//
//  TagQuestionsViewController.swift
//  StackOverFlowClient
//
//  Created by Mariganesh on 11/01/20.
//  Copyright © 2020 Tart Labs. All rights reserved.
//

import UIKit
import Reusable

class TagQuestionsViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,TagTapProtocol,QuestionsProtocol {
    
    private var selctedTag:String!
    private var questions:[Question] = []
    private var currentPage:Int = 1
    private var lastPage = 100
    private var isLoadingMore:Bool = false

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selctedTag
        
        self.tableView.register(cellType: QuestionTableViewCell.self)
        self.tableView.register(cellType: LoadingTableViewCell.self)
        getQuestions()
    }
    
    public func setTag(tag:String){
        self.selctedTag = tag
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return self.questions.count
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell:QuestionTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.populateData(question: self.questions[indexPath.row], listener: self)
            return cell
        case 1:
            let cell:LoadingTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setText(text: "")
            if currentPage >= lastPage{
                cell.hideLoadingSpinner()
            }else {
                cell.startAnimation()
            }
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height * 4 {
            if currentPage < lastPage && !isLoadingMore {
                self.currentPage += 1
                getQuestions()
            }
        }
    }
    
    private func getQuestions(){
        isLoadingMore = true
        HomeService.getTagquestions(currentPage: self.currentPage,
                                    tag: self.selctedTag,
                                    view: self)
    }
    
    
    
    //TagTapProtocol function
    
    func onTagPressed(tagTitle: String) {
        self.selctedTag = tagTitle
        self.title = tagTitle
        self.questions = []
        self.tableView.reloadData()
        self.currentPage = 1
        getQuestions()
    }
    
    //QuestionsProtocol function
    
    func onAllQuestionSuccess(questions: [Question]) {
        self.questions.append(contentsOf: questions)
        isLoadingMore = false
        self.tableView.reloadData()
    }
    
    func onAllQuestionFailure(message: String) {
        showToast(message)
    }
}
