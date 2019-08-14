//
//  TrainingActionButton.swift
//  Gymart
//
//  Created by William on 14/08/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit

class TrainingActionButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI() {
        titleLabel?.font = UIFont.mainRegularFont(size: 16)
        setTitleColor(.white, for: .normal)
        backgroundColor = UIColor.green
        layer.roundedCorner(11)
    }
}
