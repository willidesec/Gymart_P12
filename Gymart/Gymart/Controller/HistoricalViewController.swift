//
//  HistoricalViewController.swift
//  Gymart
//
//  Created by William on 17/08/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit

class HistoricalViewController: UIViewController {
    
    // MARK: - Properties
    
    var historicalWorkouts = [HistoricalWorkout]()
    
    // MARK: - IBOutlet

    @IBOutlet weak var historicalTableView: UITableView!
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchHistoricalWorkouts()
    }
    
    private func fetchHistoricalWorkouts() {
        
        let firestoreService = FirestoreService()
        firestoreService.fetchCollectionData(endpoint: .historical) { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error.localizedDescription)")
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
