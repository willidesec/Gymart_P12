//
//  ProfileViewController.swift
//  Gymart
//
//  Created by William on 29/06/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit

class ProfilViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var profileContainer: UIView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailProfilLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userNameProfilLabel: UILabel!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchProfilInformation()
    }
    
    // MARK: - IBAction
    
    @IBAction func signOutItemDidTapped(_ sender: UIBarButtonItem) {
        signOut()
    }
    
    // MARK: - Methods UI
    
    private func setupUI() {
        setupShadowView()
        setupContainerView()
        setupImageView()
        setupLabels()
    }
    
    private func setupShadowView() {
        shadowView.layer.roundedCorner(10)
        shadowView.layer.addShadow(color: .black, opacity: 0.2, width: 0.0, height: 1.0, radius: 4.0, spread: 0)
    }
    
    private func setupContainerView() {
        profileContainer.layer.roundedCorner(shadowView.layer.cornerRadius)
        profileContainer.layer.masksToBounds = true
    }
    
    private func setupImageView() {
        userImageView.layer.borderWidth = 3
        userImageView.layer.cornerRadius = userImageView.frame.height / 2
        userImageView.layer.borderColor = UIColor.grey.cgColor
    }
    
    private func setupLabels() {
        emailLabel.text = Constants.Placeholder.email
        emailProfilLabel.text = Constants.Placeholder.email
        userNameLabel.text = Constants.Placeholder.userName
        userNameProfilLabel.text = Constants.Placeholder.userName
    }
    
    private func updateScreenWithProfil(_ profil: Profil) {
        emailProfilLabel.text = profil.email
        userNameProfilLabel.text = profil.userName
    }
    
    // MARK: - Methods WebService
    
    private func fetchProfilInformation() {
        
        let firestoreService = FirestoreService()
        firestoreService.fetchDocumentData(endpoint: .user) { (document, _) in
            if let document = document, document.exists {
                guard let profil = document.data().map({Profil(dictionary: $0)}) as? Profil else { return }
                self.updateScreenWithProfil(profil)
            } else {
                print("Document does not exist")
                self.displayAlert(message: Constants.AlertError.serverError)
            }
        }
    }
    
    private func signOut() {
        let signOutAction = UIAlertAction(title: Constants.ActionSheet.signOutAction, style: .destructive) { _ in
            do {
                let authService = AuthService()
                try authService.signOut()
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
