//
//  ProfileViewController.swift
//  Gymart
//
//  Created by William on 29/06/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var profileContainer: UIView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - IBAction
    
    @IBAction func signOutItemDidTapped(_ sender: UIBarButtonItem) {
        let signOutAction = UIAlertAction(title: Constants.ActionSheet.signOutAction, style: .destructive) { (action) in
            do {
                try Auth.auth().signOut()
                let loginStoryboard = UIStoryboard(name: "Login&Register", bundle: nil)
                let loginVC = loginStoryboard.instantiateViewController(withIdentifier: "Login")
                self.present(loginVC, animated: true, completion: nil)
            } catch let error {
                print(error.localizedDescription)
                self.displayAlert(title: Constants.AlertError.signOutError, message: error.localizedDescription)
            }
        }
        
        displayActionSheet(action: signOutAction)
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        profileContainer.layer.roundedCorner(10)
        profileContainer.layer.addShadow(color: .black, opacity: 0.2, width: 0.0, height: 1.0, radius: 4.0, spread: 0)
        
        userImageView.layer.borderWidth = 3
        userImageView.layer.cornerRadius = userImageView.frame.height / 2
        userImageView.layer.borderColor = UIColor.grey.cgColor
    }
    
}
