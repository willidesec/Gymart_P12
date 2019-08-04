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
        fetchWorkouts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        workouts.removeAll()
        workoutsTableView.reloadData()
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
    
    // MARK: - IBAction
    
    @objc func addItemTapped() {
        
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
//            deleteProgramInFirestore(id: programs[indexPath.row].id)
//            programs.remove(at: indexPath.row)
//            programTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Training", bundle:nil)
//        guard let workoutsVC = storyBoard.instantiateViewController(withIdentifier: "Workouts") as? WorkoutsViewController else { return }
//        workoutsVC.programId = programs[indexPath.row].id
//        navigationController?.pushViewController(workoutsVC, animated: true)
    }
    
    
}

extension WorkoutViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heightRow: CGFloat = 200
        return heightRow
    }
}
