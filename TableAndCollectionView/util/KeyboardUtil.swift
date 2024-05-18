//
//  KeyboardUtil.swift
//  TableAndCollectionView
//
//  Created by @suonvicheakdev on 18/5/24.
//

import UIKit

class KeyboardUtil {
    
    var viewController: UIViewController!
    var view: UIView!
    var bottomConstraint: NSLayoutConstraint!
    
    init(viewController: UIViewController!, view: UIView!, bottomConstraint: NSLayoutConstraint!) {
        self.viewController = viewController
        self.view = view
        self.bottomConstraint = bottomConstraint
    }
    
    open func keyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func showKeyboard(notification: Notification){
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        bottomConstraint.constant = keyboardFrame.height
        view.layoutIfNeeded()
    }
    
    @objc func hideKeyboard(){
        bottomConstraint.constant = 0
        view.layoutIfNeeded()
    }
    
}
