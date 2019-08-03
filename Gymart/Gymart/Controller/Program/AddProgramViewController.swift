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
    
    var ref: DocumentReference? = nil
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
        dismiss(animated: true, completion: nil)
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
        
        let newProgram = Program(id: "", name: programName, description: programDescription, creationDate: Date())
        
        saveProgramInFirestore(newProgram.dictionary)
        
    }
    
    private func saveProgramInFirestore(_ data: [String: Any]) {
        db = Firestore.firestore()
        
        guard let currentUser = AuthService.getCurrentUser() else { return }
        
        let userDoc = db.collection("users").document(currentUser.uid)
        
        ref = userDoc.collection("programs").addDocument(data: data) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(self.ref!.documentID)")
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
