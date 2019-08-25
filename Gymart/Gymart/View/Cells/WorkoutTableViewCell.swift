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
    
    var workout: Workout? {
        didSet {
            workoutNameLabel.text = workout?.name
            
            if let lastWorkoutDate = workout?.lastWorkoutDate {
                displayCorrectTimeInterval(lastWorkoutDate)
            } else {
                lastWorkoutDateLabel.text = Constants.Label.noTraining
            }
        }
    }
    
    var historicalWorkout: HistoricalWorkout? {
        didSet {
            workoutNameLabel.text = historicalWorkout?.name
            if let workoutDate = historicalWorkout?.workoutDate {
                displayCorrectTimeInterval(workoutDate)
            }
        }
    }
    
    // MARK: - View Life Cycle
    
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
    
    private func displayCorrectTimeInterval(_ date: Date) {
        let daysSinceNow = date.numberOfDaysFromNow
        if daysSinceNow == 0 {
            let timeInterval = -(date.timeIntervalSinceNow)
            let secondsInAnHour: Double = 3600.0
            let hoursSinceNow = timeInterval / secondsInAnHour
            if hoursSinceNow < 1 {
                let minutesInOneHour: Double = 60.0
                let minutesSinceNow = hoursSinceNow * minutesInOneHour
                if minutesSinceNow < 1 {
                    let secondsInOneMinute: Double = 60
                    let secondsSinceNow = minutesSinceNow * secondsInOneMinute
                    let secondsRounded = Int(secondsSinceNow.rounded())
                    if secondsRounded <= 1 {
                        lastWorkoutDateLabel.text = "\(secondsRounded) second ago"
                    } else {
                        lastWorkoutDateLabel.text = "\(secondsRounded) seconds ago"
                    }
                } else {
                    let minutesRounded = Int(minutesSinceNow.rounded())
                    if minutesRounded == 1 {
                        lastWorkoutDateLabel.text = "\(minutesRounded) minute ago"
                    } else {
                        lastWorkoutDateLabel.text = "\(minutesRounded) minutes ago"
                    }
                }
            } else {
                let hoursRounded = Int(hoursSinceNow.rounded())
                if hoursRounded == 1 {
                    lastWorkoutDateLabel.text = "\(hoursRounded) hour ago"
                } else {
                    lastWorkoutDateLabel.text = "\(hoursRounded) hours ago"
                }
            }
        } else {
            if daysSinceNow == 1 {
                lastWorkoutDateLabel.text = "\(daysSinceNow) day ago"
            } else {
                lastWorkoutDateLabel.text = "\(daysSinceNow) days ago"
            }
        }
    }

}

// MARK: - Extensions

extension WorkoutTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let workout = workout {
            return workout.exercicesData.count
        } else if let historicalWorkout = historicalWorkout {
            return historicalWorkout.exercicesData.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExercicesTableViewCell.identifier) as? ExercicesTableViewCell else { return UITableViewCell() }
        
        if let workout = workout {
            let exercices = workout.exercicesData.compactMap({Exercice(dictionary: $0)})
            cell.exercice = exercices[indexPath.row]
        } else if let historicalWorkout = historicalWorkout {
            let exercices = historicalWorkout.exercicesData.compactMap({HistoricalExercice(dictionary: $0)})
            cell.historicalExercice = exercices[indexPath.row]
        }
        
        return cell
    }
    
}

extension WorkoutTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heightRow: CGFloat = 30
        return heightRow
    }
}
