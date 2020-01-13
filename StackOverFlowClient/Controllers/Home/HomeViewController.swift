//
//  HomeViewController.swift
//  StackOverFlowClient
//
//  Created by Mariganesh on 06/01/20.
//  Copyright © 2020 Tart Labs. All rights reserved.
//

import UIKit
import Reusable
import XLPagerTabStrip

class HomeViewController:ButtonBarPagerTabStripViewController{
    
    private var selectedTapType:String!
    
    private var feedVC:FeedViewController!
    
    
    override func viewDidLoad() {
        // change selected bar color
        settings.style.buttonBarBackgroundColor = Constants.getThemeDarkColor
        settings.style.buttonBarItemBackgroundColor = Constants.getThemeDarkColor
        settings.style.selectedBarBackgroundColor = .white
        settings.style.buttonBarItemFont = UIFont(name: Fonts.GoogleSansMedium.toString(), size: 16)!
        
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .white
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        changeCurrentIndexProgressive = {(oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.8)
            newCell?.label.textColor = .white
        }
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if let controller = self.navigationController {
            controller.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Stack Overflow"
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        self.feedVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "FeedViewController") as? FeedViewController
        feedVC.setPollsTapType(type: SortType.Activity)
        
        let hotVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
        hotVC.setPollsTapType(type: SortType.Hot)
        
        let votesVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
        votesVC.setPollsTapType(type: SortType.Votes)
        
        let dateVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
        dateVC.setPollsTapType(type: SortType.Creation)
        
        return [feedVC,hotVC,votesVC,dateVC]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.title = ""
    }
}
