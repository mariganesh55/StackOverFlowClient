//
//  QuestionTableViewCell.swift
//  StackOverFlowClient
//
//  Created by Mariganesh on 11/01/20.
//  Copyright © 2020 Tart Labs. All rights reserved.
//

import UIKit
import Reusable
import TagListView

class QuestionTableViewCell: UITableViewCell,NibReusable,TagListViewDelegate {
    
    
    private var listener:TagTapProtocol!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var votewCountLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagListView: TagListView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.tagListView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func populateData(question:Question,listener:TagTapProtocol){
        
        votewCountLabel.text = "\(question.getVoteCount())"
        titleLabel.text = question.getTitle()
        timeLabel.text = question.getTimeStamp()
        userNameLabel.text = question.getDisplayName()
        self.listener = listener
        
        self.tagListView.removeAllTags()
        question.getTags().forEach { (tagName) in
           self.tagListView.addTag(tagName)
        }
        
        self.updateConstraintsIfNeeded()
    }
    
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        if let listener = self.listener{
            listener.onTagPressed(tagTitle: title)
        }
    }
}

public protocol TagTapProtocol {
    func onTagPressed(tagTitle:String)
}
