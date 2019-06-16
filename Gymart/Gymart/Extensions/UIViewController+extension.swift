//
//  UIViewController+extension.swift
//  Gymart
//
//  Created by William on 09/06/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit

// MARK: - UIAlert
extension UIViewController {
    internal func displayAlert(message: String) {
        let alertVC = UIAlertController(title: Constants.Alert.title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constants.Alert.okMessage, style: .default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
}

// MARK: - UITextField
extension UIViewController {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension UIViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension UIViewController {
    internal func createKeyboardNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    internal func removeKeyboardNotificationObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    
    @objc func keyboardWillChange(notification: Notification) {
        let MAX_MOVING_HEIGHT: CGFloat = 150.0
//        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
//            return
//        }
        
//        let logInButtonOriginY = logInButton.frame.origin.y
//        let distanceFromBottom = view.frame.height - logInButtonOriginY
//        var keyboardMovingHeight: CGFloat = 0.0
        
//        if distanceFromBottom < keyboardRect.height {
//            keyboardMovingHeight = keyboardRect.height - distanceFromBottom
//        }
        
//        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
        if notification.name == UIResponder.keyboardWillShowNotification  {
            view.frame.origin.y = -MAX_MOVING_HEIGHT
        } else {
            view.frame.origin.y = 0
        }
    }
}


