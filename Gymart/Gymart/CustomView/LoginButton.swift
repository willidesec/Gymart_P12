//
//  LoginButton.swift
//  Gymart
//
//  Created by William on 08/06/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit

class LoginButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        layer.roundedCorner()
        backgroundColor = UIColor.blue
        tintColor = .white
        titleLabel?.font = UIFont.mainRegularFont(size: 15)
        layer.addShadow()
    }
    
}
