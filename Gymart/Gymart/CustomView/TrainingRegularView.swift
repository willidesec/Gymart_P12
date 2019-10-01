//
//  TrainingRegularView.swift
//  Gymart
//
//  Created by William on 15/08/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit

class TrainingRegularView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = UIColor.grey
        layer.roundedCorner(8)
    }
}
