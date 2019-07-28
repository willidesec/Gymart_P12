//
//  ExercicesTableViewCell.swift
//  Gymart
//
//  Created by William on 28/07/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit

class ExercicesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var exerciceNameLabel: UILabel!
    
    var exercice: Exercice? {
        didSet {
            exerciceNameLabel.text = exercice?.name
        }
    }
}
