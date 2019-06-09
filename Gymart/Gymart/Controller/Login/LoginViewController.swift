//
//  LoginViewController.swift
//  Gymart
//
//  Created by William on 08/06/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var emailUserInput: UserInputView!
    @IBOutlet weak var passwordUserInput: UserInputView!
    @IBOutlet weak var logInButton: LoginButton!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextField()
        createKeyboardNotificationObservers()
    }
    
    deinit {
        removeKeyboardNotificationObservers()
    }
    
    // MARK: - Methods
    private func createKeyboardNotificationObservers() {
        // Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    private func removeKeyboardNotificationObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    
    @objc func keyboardWillChange(notification: Notification) {
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        print(notification.name)
        
        let logInButtonOriginY = logInButton.frame.origin.y
        let distanceFromBottom = view.frame.height - logInButtonOriginY
        let keyboardMovingHeight = keyboardRect.height - distanceFromBottom
        
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            view.frame.origin.y = -keyboardMovingHeight
        } else {
            view.frame.origin.y = 0
        }
    }
    
    private func configureTextField() {
        guard let emailImage = #imageLiteral(resourceName: "email").cgImage else { return }
        emailUserInput.iconImageView.image = UIImage(cgImage: emailImage)
        emailUserInput.textField.placeholder = Constants.Placeholder.email
        emailUserInput.textField.keyboardType = .emailAddress
        emailUserInput.textField.returnKeyType = .next
        emailUserInput.textField.delegate = self
        
        guard let podlockImage = #imageLiteral(resourceName: "padlock").cgImage else { return }
        passwordUserInput.iconImageView.image = UIImage(cgImage: podlockImage)
        passwordUserInput.textField.placeholder = Constants.Placeholder.password
        passwordUserInput.textField.isSecureTextEntry = true
        passwordUserInput.textField.delegate = self
    }

}
