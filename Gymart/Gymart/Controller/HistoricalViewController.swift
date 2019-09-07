//
//  HistoricalViewController.swift
//  Gymart
//
//  Created by William on 17/08/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit
import FirebaseFirestore

class HistoricalViewController: UIViewController {
    
    // MARK: - Properties
    
    var historicalWorkouts = [HistoricalWorkout]()
    var db: Firestore!
    
    // MARK: - IBOutlet

    @IBOutlet weak var historicalTableView: UITableView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureFirestoreDataBase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchHistoricalWorkouts()
    }
    
    // MARK: - Methods
    
    private func configureFirestoreDataBase() {
        db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
    
    private func fetchHistoricalWorkouts() {
        guard let currentUser = AuthService.getCurrentUser() else { return }

        let historicalCollection = db.collection("users/\(currentUser.uid)/historical")

        historicalCollection.order(by: "workoutDate", descending: true).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err.localizedDescription)")
            } else {
                self.historicalWorkouts = querySnapshot!.documents.compactMap({HistoricalWorkout(dictionary: $0.data())})
                DispatchQueue.main.async {
                    self.historicalTableView.reloadData()
                }
            }
        }
    }
    
}

// MARK: - Extensions

extension HistoricalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historicalWorkouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WorkoutTableViewCell.identifier, for: indexPath) as? WorkoutTableViewCell else {
            return UITableViewCell()
        }
        
        cell.historicalWorkout = historicalWorkouts[indexPath.row]
        cell.exercicesTableView.reloadData()
        
        return cell
    }
    
}

extension HistoricalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heightRow: CGFloat = 200
        return heightRow
    }
}
