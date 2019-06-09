//
//  RegisterViewController.swift
//  Gymart
//
//  Created by William on 09/06/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var userNameInput: UserInputView!
    @IBOutlet weak var emailUserInput: UserInputView!
    @IBOutlet weak var passwordUserInput: UserInputView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextField()
        
    }
    
    // MARK: - IBAction
    
    @IBAction func cancelButtonDidTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Methods
    private func configureTextField() {
        guard let userImage = #imageLiteral(resourceName: "email").cgImage else { return }
        userNameInput.iconImageView.image = UIImage(cgImage: userImage)
        userNameInput.textField.placeholder = Constants.Placeholder.userName
        userNameInput.textField.keyboardType = .default
        userNameInput.textField.returnKeyType = .next
        //        emailUserInput.textField.delegate = self
        
        
        guard let emailImage = #imageLiteral(resourceName: "email").cgImage else { return }
        emailUserInput.iconImageView.image = UIImage(cgImage: emailImage)
        emailUserInput.textField.placeholder = Constants.Placeholder.email
        emailUserInput.textField.keyboardType = .emailAddress
        emailUserInput.textField.returnKeyType = .next
//        emailUserInput.textField.delegate = self
        
        guard let podlockImage = #imageLiteral(resourceName: "padlock").cgImage else { return }
        passwordUserInput.iconImageView.image = UIImage(cgImage: podlockImage)
        passwordUserInput.textField.placeholder = Constants.Placeholder.password
        passwordUserInput.textField.isSecureTextEntry = true
//        passwordUserInput.textField.delegate = self
    }
}
