//
//  AddExerciceTableViewCell.swift
//  Gymart
//
//  Created by William on 04/08/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit

class AddExerciceTableViewCell: UITableViewCell {

    
    // MARK: - IBOutlet
    
    @IBOutlet weak var exerciceNameLabel: UILabel!
    @IBOutlet weak var setsLabel: UILabel!
    
    // MARK: - Properties
    var exercice: Exercice? {
        didSet {
            guard let exercice = exercice else { return }
            exerciceNameLabel.text = exercice.name
            setsLabel.text = String(exercice.sets)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
