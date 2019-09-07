//
//  UIImageView+extensions.swift
//  Gymart
//
//  Created by William on 15/08/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
