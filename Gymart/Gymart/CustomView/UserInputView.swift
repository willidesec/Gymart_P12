//
//  LoginTextField.swift
//  Gymart
//
//  Created by William on 08/06/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit

class UserInputView: UIView {
    
    // MARK: - Views
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let textField: UITextField = {
       let textfield = UITextField()
        textfield.tintColor = UIColor.silver
        textfield.textColor = UIColor.blue
        textfield.autocapitalizationType = .none
        textfield.font = UIFont.mainObliqueFont(size: 16)
        textfield.clearButtonMode = .always
        textfield.autocorrectionType = .no
        textfield.spellCheckingType = .no
        return textfield
    }()
    
    // MARK: - Init
    override func awakeFromNib() {
        setupUI()
    }
    
    // MARK: - Methods
    private func setupUI() {
        setupBorder()
        [iconImageView, textField].forEach { addSubview($0) }
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        iconImageView.centerY(to: self)
        iconImageView.setAnchors(top: nil,
                                 leading: self.leadingAnchor,
                                 bottom: nil,
                                 trailing: nil,
                                 padding: UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 0), size: CGSize(width: 22.0, height: 22.0))
        
        textField.centerY(to: self)
        textField.setAnchors(top: nil,
                             leading: iconImageView.trailingAnchor,
                             bottom: nil,
                             trailing: self.trailingAnchor,
                             padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 22))
    }
    
    private func setupBorder() {
        layer.borderColor = UIColor.silver.cgColor
        layer.borderWidth = 1.0
        layer.roundedCorner()
    }
}
