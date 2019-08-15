//
//  TrainingTableViewCell.swift
//  Gymart
//
//  Created by William on 15/08/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit

class TrainingTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var setLabel: UILabel!
    @IBOutlet weak var emptyPreviousView: UIView!
    @IBOutlet weak var previousSetLabel: UILabel!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var repsTextField: UITextField!
    @IBOutlet weak var checkedImageView: UIImageView!
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        emptyPreviousView.layer.roundedCorner()
        
        checkedImageView.setImageColor(color: UIColor.silver)
    }
}
