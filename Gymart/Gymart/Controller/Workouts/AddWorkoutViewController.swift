//
//  AddWorkoutViewController.swift
//  Gymart
//
//  Created by William on 04/08/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit

class AddWorkoutViewController: UIViewController {

    // MARK: - Properties
    
    var exercices = [Exercice]()
    var programId: String?
    
    // MARK: - IBOutlet
    @IBOutlet weak var workoutNameTextField: UITextField!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var exerciceNameTextField: UITextField!
    @IBOutlet weak var numberOfSetsTextField: UITextField!
    @IBOutlet weak var exerciceTableView: UITableView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSeparatorView()
        configureTableView()
    }
    
    // MARK: - IBAction
    
    @IBAction func cancelButtonDidTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonDidTapped(_ sender: UIBarButtonItem) {
        saveNewWorkout()
    }
    
    @IBAction func addExerciceButtonDidTapped() {
        addExerciceToTableView()
    }
    
    // MARK: - Methods
    
    private func configureSeparatorView() {
        separatorView.layer.borderColor = UIColor.silver.cgColor
        separatorView.layer.borderWidth = 1
    }
    
    private func configureTableView() {
        exerciceTableView.delegate = self
        exerciceTableView.dataSource = self
        exerciceTableView.tableFooterView = UIView()
    }
    
    private func addExerciceToTableView() {
        guard let exerciceName = exerciceNameTextField.text, !exerciceName.isEmpty else {
            displayAlert(message: Constants.Alert.noExerciceName)
            return
        }
        
        guard let stringSets = numberOfSetsTextField.text, !stringSets.isEmpty else {
            displayAlert(message: Constants.Alert.noExerciceSet)
            return
        }
        
        guard let numberOfSets = Int(stringSets) else { return }
        
        let exercice = Exercice(name: exerciceName, sets: numberOfSets)
        exercices.append(exercice)
        exerciceTableView.reloadData()
        removeInputInTextFields()
    }
    
    private func saveNewWorkout() {
        guard let workoutName = workoutNameTextField.text, !workoutName.isEmpty else {
            displayAlert(message: Constants.Alert.noWorkoutName)
            return
        }
        
        if exercices.isEmpty {
            displayAlert(message: Constants.Alert.noWorkoutExercices)
        } else {
            let identifier = UUID().uuidString
            let newWorkout = Workout(identifier: identifier, name: workoutName, creationDate: Date(), exercices: exercices)
            saveWorkoutInFirestore(identifier: identifier, workout: newWorkout)
        }
    }
    
    private func saveWorkoutInFirestore(identifier: String, workout: Workout) {
        guard let programId = programId else { return }
        let firestoreService = FirestoreService<Workout>()
        firestoreService.saveData(endpoint: .workout(programId: programId), identifier: identifier, data: workout.dictionary) { [weak self] result in
            switch result {
            case .success(let successMessage):
                print(successMessage)
                self?.dismiss(animated: true, completion: nil)
            case .failure(let error):
                print("Error adding document: \(error)")
                self?.displayAlert(message: Constants.AlertError.serverError)
            }
        }
    }
    
    private func removeInputInTextFields() {
        exerciceNameTextField.text = ""
        numberOfSetsTextField.text = ""
        exerciceNameTextField.becomeFirstResponder()
    }

}

// MARK: - Extensions

extension AddWorkoutViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddExerciceTableViewCell.identifier, for: indexPath) as? AddExerciceTableViewCell else {
            return UITableViewCell()
        }
        
        cell.exercice = exercices[indexPath.row]
        
        return cell
    }
}

extension AddWorkoutViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = Constants.FooterView.noExercices
        label.font = UIFont.mainRegularFont(size: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .darkText
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return exercices.isEmpty ? 200 : 0
    }
}
