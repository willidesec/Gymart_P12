//
//  TrainingHeaderTableViewCell.swift
//  Gymart
//
//  Created by William on 15/08/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit

class TrainingHeaderTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlert
    
    @IBOutlet weak var exerciceNameLabel: UILabel!
    
    // MARK: - Properties
    
    var exercice: Exercice? {
        didSet {
            exerciceNameLabel.text = exercice?.name
        }
    }
    
    // MARK: - Init
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: - Methods
    
    
}
