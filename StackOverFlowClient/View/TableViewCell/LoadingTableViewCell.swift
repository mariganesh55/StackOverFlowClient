//
//  LoadingTableViewCell.swift
//  StackOverFlowClient
//
//  Created by Mariganesh on 11/01/20.
//  Copyright © 2020 Tart Labs. All rights reserved.
//

import UIKit
import Reusable

class LoadingTableViewCell: UITableViewCell,NibReusable {

    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var noMorePostLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }
    
    public func setText(text: String) {
        self.noMorePostLabel.text = text
    }
    
    override func prepareForReuse() {
        loadingView.isHidden = false
        noMorePostLabel.isHidden = true
    }
    
    public func startAnimation(){
        loadingView.isHidden = false
        loadingView.startAnimating()
    }
    
    public func hideAll(){
        loadingView.isHidden = true
        noMorePostLabel.isHidden = true
    }
    
    public func hideLoadingSpinner(){
        loadingView.isHidden = true
        noMorePostLabel.isHidden = false
    }
    
    public func setBackGroudColor(color:UIColor){
        self.backgroundColor = color
    }
    
}
