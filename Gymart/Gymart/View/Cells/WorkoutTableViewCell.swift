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
    
    // MARK: - Properties
    var workout: Workout? {
        didSet {
            guard let workout = workout else { return }
            workoutNameLabel.text = workout.name
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
