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
    @IBOutlet weak var exercicesStackView: UIStackView!
    
    // MARK: - Properties
    let completeView = UIView()
    
    var workout: Workout? {
        didSet {
            guard let workout = workout else { return }
            workoutNameLabel.text = workout.name
            
            workout.exercices.forEach { (exercice) in
                let label = UILabel()
                label.font = UIFont.mainRegularFont(size: 17)
                label.text = exercice.name
                exercicesStackView.addArrangedSubview(label)
            }
            exercicesStackView.addArrangedSubview(completeView)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    // MARK: - Methods
    private func setupUI() {
        self.selectionStyle = .none
        containerView.layer.roundedCorner(10)
        containerView.layer.borderColor = UIColor.silver.cgColor
        containerView.layer.borderWidth = 1.0
        containerView.clipsToBounds = true
    }

}
