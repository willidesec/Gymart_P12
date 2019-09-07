//
//  LoginViewController.swift
//  Gymart
//
//  Created by William on 08/06/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit
import Firebase

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
    
    // MARK: - IBAction
    
    @IBAction func logInButtonDidTapped() {
        logIn()
        
    }
    
    // MARK: - Methods
    
    private func logIn() {
        guard let email = emailUserInput.textField.text, !email.isEmpty else {
            displayAlert(message: Constants.Alert.noEmail)
            return
        }
        guard let password = passwordUserInput.textField.text, !password.isEmpty else {
            displayAlert(message: Constants.Alert.noPassword)
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if error == nil && user != nil {
                self.dismiss(animated: true, completion: nil)
            } else {
                print("Error loging user: \(error!.localizedDescription)")
            }
        }
    }
    
    private func configureTextField() {
        guard let emailImage = #imageLiteral(resourceName: "email").cgImage else { return }
        emailUserInput.iconImageView.image = UIImage(cgImage: emailImage)
        emailUserInput.textField.placeholder = Constants.Placeholder.email
        emailUserInput.textField.keyboardType = .emailAddress
        emailUserInput.textField.returnKeyType = .done
        emailUserInput.textField.delegate = self
        
        guard let podlockImage = #imageLiteral(resourceName: "padlock").cgImage else { return }
        passwordUserInput.iconImageView.image = UIImage(cgImage: podlockImage)
        passwordUserInput.textField.placeholder = Constants.Placeholder.password
        passwordUserInput.textField.isSecureTextEntry = true
        
        passwordUserInput.textField.returnKeyType = .done
        passwordUserInput.textField.delegate = self
    }

}
