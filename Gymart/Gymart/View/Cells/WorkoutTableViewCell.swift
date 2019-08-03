//
//  WorkoutTableViewCell.swift
//  Gymart
//
//  Created by William on 20/07/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    
    @IBOutlet weak var workoutNameLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var exercicesTableView: UITableView!
    @IBOutlet weak var lastWorkoutDateLabel: UILabel!
    
    // MARK: - Properties
    
    let completeView = UIView()
    
    var workout: Workout? {
        didSet {
            workoutNameLabel.text = workout?.name
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            if let lastWorkoutDate = workout?.lastWorkoutDate {
                let stringDate = formatter.string(from: lastWorkoutDate)
                lastWorkoutDateLabel.text = stringDate
            } else {
                lastWorkoutDateLabel.text = Constants.Label.noTraining
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureExercicesTableView()
        setupUI()
    }

    // MARK: - Methods
    
    private func configureExercicesTableView() {
        exercicesTableView.delegate = self
        exercicesTableView.dataSource = self
        exercicesTableView.separatorStyle = .none
    }
    
    private func setupUI() {
        self.selectionStyle = .none
        containerView.layer.roundedCorner(10)
        containerView.layer.borderColor = UIColor.silver.cgColor
        containerView.layer.borderWidth = 1.0
        containerView.clipsToBounds = true
    }

}

// MARK: - Extensions

extension WorkoutTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workout?.exercices.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExercicesTableViewCell.identifier) as? ExercicesTableViewCell else { return UITableViewCell() }
        
        cell.exercice = workout?.exercices[indexPath.row]
        
        return cell
    }
    
    
}

extension WorkoutTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heightRow: CGFloat = 30
        return heightRow
    }
}
