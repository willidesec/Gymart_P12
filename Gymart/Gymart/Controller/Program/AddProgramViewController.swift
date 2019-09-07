//
//  AddProgramViewController.swift
//  Gymart
//
//  Created by William on 30/06/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit
import Firebase

class AddProgramViewController: UIViewController {

    // MARK: - Properties
    
    var db: Firestore!
    
    // MARK: - IBOutlet
    
    @IBOutlet var separatorViews: [UIView]!
    @IBOutlet weak var programNameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureSeparatorView()
    }
    
    // MARK: - IBAction
    
    @IBAction func saveItemDidTapped(_ sender: UIBarButtonItem) {
        saveNewProgram()
    }
    
    @IBAction func cancelItemDidTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Methods
    
    private func saveNewProgram() {
        guard let programName = programNameTextField.text, !programName.isEmpty else {
            print("No Program Name")
            return
        }
        
        guard let programDescription = descriptionTextField.text, !description.isEmpty else {
            print("No description")
            return
        }
        let identifier = UUID().uuidString
        let newProgram = Program(id: identifier, name: programName, description: programDescription, creationDate: Date())
        
        saveProgramInFirestore(id: identifier, data: newProgram.dictionary)
        
    }
    
    private func saveProgramInFirestore(id: String, data: [String: Any]) {
        db = Firestore.firestore()
        
        guard let currentUser = AuthService.getCurrentUser() else { return }
        let programsCollection = db.collection("users/\(currentUser.uid)/programs")
        programsCollection.document(id).setData(data) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with success")
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    private func configureSeparatorView() {
        separatorViews.forEach { (separator) in
            separator.layer.borderColor = UIColor.silver.cgColor
            separator.layer.borderWidth = 1
        }
    }
    
    
}
