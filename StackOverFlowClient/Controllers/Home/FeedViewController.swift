//
//  FeedViewController.swift
//  StackOverFlowClient
//
//  Created by Mariganesh on 11/01/20.
//  Copyright © 2020 Tart Labs. All rights reserved.
//

import UIKit
import Reusable
import XLPagerTabStrip

class FeedViewController: BaseViewController,IndicatorInfoProvider, UITableViewDelegate,UITableViewDataSource,QuestionsProtocol,TagTapProtocol  {
    
    private var selectedTapType:SortType!
    private var selectedTag:String!
    private var questions:[Question] = []
    private var currentPage:Int = 1
    private var lastPage = 100
    private var isLoadingMore:Bool = false
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tableView.register(cellType: QuestionTableViewCell.self)
        self.tableView.register(cellType: LoadingTableViewCell.self)
        HomeService.getAllQuestions(currentPage: self.currentPage,
                                    sortType: self.selectedTapType,
                                    view: self)
        
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
    
    public func setPollsTapType(type:SortType) {
        self.selectedTapType = type
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
       
         return IndicatorInfo(title: self.selectedTapType.toString().capitalizingFirstLetter())
    }
    
    //pagination
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height * 4 {
            if currentPage < lastPage && !isLoadingMore {
                self.currentPage += 1
                isLoadingMore = true
                HomeService.getAllQuestions(currentPage: self.currentPage,
                                            sortType: self.selectedTapType,
                                            view: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ShowTagQuestionsPage":
            if let destination = segue.destination as? TagQuestionsViewController{
                destination.setTag(tag: self.selectedTag)
            }
            break
        default:
            break
        }
    }
    
    //QuestionsProtocol function
    
    func onAllQuestionSuccess(questions: [Question]) {
        isLoadingMore = false
        self.questions.append(contentsOf: questions)
        self.tableView.reloadData()
    }
    
    func onAllQuestionFailure(message: String) {
        showToast(message)
    }
    
    //TagTapProtocol function
    
    func onTagPressed(tagTitle: String) {
        self.selectedTag = tagTitle
        performSegue(withIdentifier: "ShowTagQuestionsPage", sender: self)
    }
}
