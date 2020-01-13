//
//  BaseViewController.swift
//  StackOverFlowClient
//
//  Created by Mariganesh on 11/01/20.
//  Copyright © 2020 Tart Labs. All rights reserved.
//

import UIKit
import Toast_Swift

class BaseViewController: UIViewController {
    
    internal var keyboardHeight:CGFloat = 0
    internal var isKeyboardShown:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // keyboard show and hide listeners
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShown), name:UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func clearNavigationBackButtonTitle() {
        guard let navigationItem = self.navigationController?.navigationItem else {
            return
        }
        navigationItem.backBarButtonItem?.title = ""
    }
    internal func makeNavTransparent(){
        guard let controller = navigationController else {
            return
        }
        controller.navigationBar.isTranslucent = true
        controller.navigationBar.setBackgroundImage(UIImage(), for: .default)
        controller.navigationBar.shadowImage = UIImage()
        controller.navigationBar.backgroundColor = .clear
    }
    
    internal func hideNavigationBar() {
        if let controller = self.navigationController {
            controller.setNavigationBarHidden(true, animated: true)
        }
    }
    
    internal func showNavigationBar() {
        if let controller = self.navigationController {
            controller.setNavigationBarHidden(false, animated: true)
        }
    }
    
    internal func changeNavigationTitleColor(uicolor:UIColor){
        if let controller = self.navigationController{
            controller.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:uicolor]
        }
    }
    
    internal func showLoading(){
        UIApplication.shared.beginIgnoringInteractionEvents()
        self.view.makeToastActivity(.center)
    }
    
    internal func hideLoading(){
        if UIApplication.shared.isIgnoringInteractionEvents {
            UIApplication.shared.endIgnoringInteractionEvents()
            self.view.hideToastActivity()
        }
    }
    
    internal func removeLastViewControllers(count:Int){
        if let controller = self.navigationController{
            var navigationArray = controller.viewControllers
            navigationArray.removeLast(count)
            controller.viewControllers = navigationArray
        }
    }
    
    @objc internal func keyboardShown(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        self.isKeyboardShown = true
        self.keyboardHeight = keyboardFrame.height
    }
    
    @objc internal func keyboardHidden(){
        self.isKeyboardShown = false
    }
    
    internal func showToast(_ message:String){
        let x = self.view.bounds.size.width / 2.0
        var point:CGPoint
        if isKeyboardShown {
            point = CGPoint(x:x, y:(view.bounds.size.height - keyboardHeight - 50) - 10) // 50 (toast height ~100px) and 10 (safe margin) height and padding adjustments
        }else{
            point = CGPoint(x: view.bounds.size.width / 2.0, y: (view.bounds.size.height - 50) - 10)
        }
        self.view.makeToast(message, point: point, title: nil, image: nil, completion: nil)
    }
    
    internal func setNavigationTintColor(color:UIColor = UIColor.white) {
        if let controller = self.navigationController {
            controller.navigationBar.tintColor = color
        }
    }
}


