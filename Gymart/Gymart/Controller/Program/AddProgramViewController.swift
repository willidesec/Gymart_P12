//
//  AddProgramViewController.swift
//  Gymart
//
//  Created by William on 30/06/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit

class AddProgramViewController: UIViewController {
    
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
            displayAlert(message: Constants.Alert.noProgramName)
            return
        }
        
        guard let programDescription = descriptionTextField.text, !description.isEmpty else {
            displayAlert(message: Constants.Alert.noProgramDescription)
            return
        }
        let identifier = UUID().uuidString
        let newProgram = Program(identifier: identifier, name: programName, description: programDescription, creationDate: Date())
        
        saveProgramInFirestore(identifier: identifier, data: newProgram.dictionary)
        
    }
    
    private func saveProgramInFirestore(identifier: String, data: [String: Any]) {
        
        let firestoreService = FirestoreServiceOld()
        firestoreService.saveDataInFirestore(endpoint: .program, identifier: identifier, data: data) { (error) in
            if let error = error {
                print("Error adding document: \(error)")
                self.displayAlert(message: Constants.AlertError.serverError)
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
