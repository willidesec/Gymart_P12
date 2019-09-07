//
//  MainViewController.swift
//  Gymart
//
//  Created by William on 29/06/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainViewController: UITabBarController {

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIfUserLoggedIn()
    }
    
    // MARK: - Methods
    
    private func checkIfUserLoggedIn() {
        DispatchQueue.main.async {
            if Auth.auth().currentUser == nil {
                let loginStoryboard = UIStoryboard(name: "Login&Register", bundle: nil)
                let loginVC = loginStoryboard.instantiateViewController(withIdentifier: "Login")
                self.present(loginVC, animated: false, completion: nil)
            } else {
                print("user already log in")
            }
            return
        }
        
    }

}
