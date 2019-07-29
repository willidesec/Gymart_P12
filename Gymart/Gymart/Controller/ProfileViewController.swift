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
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    
}
