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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let a = HistoricalWorkout(name: "Test", workoutDate: Date(), exercices: [HistoricalExercice(name: "TEST", sets: [ExerciceSet(numeroOfSet: 1, reps: 1, weight: 1), ExerciceSet(numeroOfSet: 2, reps: 2, weight: 2)])])
        historicalWorkouts.append(a)
    }
    
}

// MARK: - Extensions

extension HistoricalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historicalWorkouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WorkoutTableViewCell.identifier, for: indexPath) as? WorkoutTableViewCell else { return UITableViewCell() }
        
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
