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
    
    @IBOutlet weak var emptyPreviousView: UIView!
    @IBOutlet weak var setLabel: UILabel!
    
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        emptyPreviousView.layer.roundedCorner()
    }
}
