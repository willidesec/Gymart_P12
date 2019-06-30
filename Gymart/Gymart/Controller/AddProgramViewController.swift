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
            print("No Program Name")
            return
        }
        
        var programDescription: String?
        if let description = descriptionTextField.text, !description.isEmpty {
            programDescription = description
        }
        
        let newProgram = Program(name: programName, description: programDescription)
        
    }
    
    private func configureSeparatorView() {
        separatorViews.forEach { (separator) in
            separator.layer.borderColor = UIColor.silver.cgColor
            separator.layer.borderWidth = 1
        }
    }
    
    
}
