//
//  WorkoutsViewController.swift
//  Gymart
//
//  Created by William on 20/07/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit
import FirebaseFirestore

class WorkoutViewController: UIViewController {
    
    // MARK: - Properties
    
    var programId: String?
    var workouts = [Workout]()
    var db: Firestore!

    // MARK: - IBOutlet
    
    @IBOutlet weak var workoutsTableView: UITableView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureNavigationItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchWorkouts()
    }
    
    // MARK: - Methods
    
    private func configureTableView() {
        workoutsTableView.delegate = self
        workoutsTableView.dataSource = self
        workoutsTableView.separatorStyle = .none
    }
    
    private func configureNavigationItem() {
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemTapped))
        navigationItem.rightBarButtonItem = addItem
    }
    
    private func fetchWorkouts() {
        db = Firestore.firestore()
        
        guard let currentUser = AuthService.getCurrentUser() else { return }
        guard let programId = programId else { return }
        
        let workoutsCollection = db.collection("users/\(currentUser.uid)/programs/\(programId)/workouts")
        
        workoutsCollection.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err.localizedDescription)")
            } else {
                self.workouts = querySnapshot!.documents.compactMap({Workout(dictionary: $0.data())})
                DispatchQueue.main.async {
                    self.workoutsTableView.reloadData()
                }
            }
        }
    }
    
    private func deleteWorkoutInFirestore(id: String) {
        guard let currentUser = AuthService.getCurrentUser() else { return }
        guard let programId = programId else { return }
        
        let workoutsCollection = db.collection("users/\(currentUser.uid)/programs/\(programId)/workouts")
        
        workoutsCollection.document(id).delete { error in
            if let error = error {
                print("Error removing document: \(error)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    // MARK: - IBAction
    
    @objc func addItemTapped() {
        let storyboard = UIStoryboard(name: "Training", bundle: nil)
        guard let addWorkoutNavigationController = storyboard.instantiateViewController(withIdentifier: "AddWorkout") as? UINavigationController else { return }
        guard let addWorkoutVC = addWorkoutNavigationController.topViewController as? AddWorkoutViewController else { return }
        addWorkoutVC.programId = programId
        present(addWorkoutNavigationController, animated: true, completion: nil)
    }

}

// MARK: - Extensions

extension WorkoutViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WorkoutTableViewCell.identifier, for: indexPath) as? WorkoutTableViewCell else { return UITableViewCell() }
        
        cell.workout = workouts[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            deleteWorkoutInFirestore(id: workouts[indexPath.row].id)
//            workouts.remove(at: indexPath.row)
//            workoutsTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Training", bundle:nil)
        guard let trainingVC = storyBoard.instantiateViewController(withIdentifier: TrainingViewController.identifier) as? TrainingViewController else { return }
        trainingVC.programId = programId
        trainingVC.workoutId = workouts[indexPath.row].id
        navigationController?.pushViewController(trainingVC, animated: true)
    }
    
    
}

extension WorkoutViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heightRow: CGFloat = 200
        return heightRow
    }
}
