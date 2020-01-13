//
//  ViewController.swift
//  StackOverFlowClient
//
//  Created by Mariganesh on 02/01/20.
//  Copyright © 2020 Tart Labs. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onLoginTapped(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "ShowHomePage", sender: self)
    }
    
}

