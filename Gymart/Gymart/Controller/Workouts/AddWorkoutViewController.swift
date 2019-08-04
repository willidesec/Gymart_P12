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
            // Alert
            return
        }
        
        guard let stringSets = numberOfSetsTextField.text, !stringSets.isEmpty else {
            // Alert
            return
        }
        
        guard let numberOfSets = Int(stringSets) else { return }
        
        let exercice = Exercice(name: exerciceName, sets: numberOfSets)
        exercices.append(exercice)
        exerciceTableView.reloadData()
    }

}

// MARK: - Extensions

extension AddWorkoutViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddExerciceTableViewCell.identifier, for: indexPath) as? AddExerciceTableViewCell else { return UITableViewCell() }
        
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
