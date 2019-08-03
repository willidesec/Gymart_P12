//
//  ExercicesTableViewCell.swift
//  Gymart
//
//  Created by William on 28/07/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit

class ExercicesTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var exerciceNameLabel: UILabel!
    
    // MARK: - Properties
    
    var exercice: Exercice? {
        didSet {
            guard let exerciceName = exercice?.name else { return }
            guard let exerciceSets = exercice?.sets else { return }
            exerciceNameLabel.text = "\(exerciceSets) x \(exerciceName)"
        }
    }
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    
    // MARK: - Methods
    
    private func setupUI() {
        self.selectionStyle = .none
    }
}
