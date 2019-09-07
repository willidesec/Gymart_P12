//
//  RegisterViewController.swift
//  Gymart
//
//  Created by William on 09/06/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    // MARK: - Properties
    
    let db = Firestore.firestore()
    var ref: DocumentReference?

    // MARK: - IBOutlet
    
    @IBOutlet weak var userNameInput: UserInputView!
    @IBOutlet weak var emailUserInput: UserInputView!
    @IBOutlet weak var passwordUserInput: UserInputView!
    
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
    
    @IBAction func cancelButtonDidTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonDidTapped() {
        createUserAccount()
    }
    
    // MARK: - Methods
    
    private func createUserAccount() {
        guard let username = userNameInput.textField.text, !username.isEmpty else {
            displayAlert(message: Constants.Alert.noUserName)
            return
        }
        guard let email = emailUserInput.textField.text, !email.isEmpty else {
            displayAlert(message: Constants.Alert.noEmail)
            return
        }
        guard let password = passwordUserInput.textField.text, !password.isEmpty else {
            displayAlert(message: Constants.Alert.noPassword)
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if error == nil && authResult != nil {
                guard let userId = Auth.auth().currentUser?.uid else { return }
                let user: [String: Any] = [
                    "userId": userId,
                    "userName": username,
                    "email": email
                ]
                self.saveUserData(user, identifier: userId)
                self.dismiss(animated: true, completion: nil)
            } else {
                print("Error creating user: \(error!.localizedDescription)")
            }
        }
    }
    
    private func saveUserData(_ user: [String: Any], identifier: String) {
        db.collection("users").document(identifier).setData(user)
    }
    
    private func configureTextField() {
        guard let userImage = #imageLiteral(resourceName: "user").cgImage else { return }
        userNameInput.iconImageView.image = UIImage(cgImage: userImage)
        userNameInput.textField.placeholder = Constants.Placeholder.userName
        userNameInput.textField.keyboardType = .default
        userNameInput.textField.returnKeyType = .done
        userNameInput.textField.delegate = self
        
        guard let emailImage = #imageLiteral(resourceName: "email").cgImage else { return }
        emailUserInput.iconImageView.image = UIImage(cgImage: emailImage)
        emailUserInput.textField.placeholder = Constants.Placeholder.email
        emailUserInput.textField.keyboardType = .emailAddress
        emailUserInput.textField.returnKeyType = .done
        emailUserInput.textField.delegate = self
        
        guard let podlockImage = #imageLiteral(resourceName: "padlock").cgImage else { return }
        passwordUserInput.iconImageView.image = UIImage(cgImage: podlockImage)
        passwordUserInput.textField.placeholder = Constants.Placeholder.password
//        passwordUserInput.textField.isSecureTextEntry = true
        passwordUserInput.textField.returnKeyType = .done
        passwordUserInput.textField.delegate = self
    }
}
