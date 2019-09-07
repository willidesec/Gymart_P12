//
//  CALayer+extension.swift
//  Gymart
//
//  Created by William on 08/06/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit

extension CALayer {
    func roundedCorner(_ radius: CGFloat? = nil) {
        if let radius = radius {
            cornerRadius = radius
        } else {
            cornerRadius = frame.height / 2
        }
    }
    
    
    func addShadow(
        color: UIColor = .black,
        opacity: Float = 0.5,
        width: CGFloat = 0,
        height: CGFloat = 2,
        radius: CGFloat = 2,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = opacity
        shadowOffset = CGSize(width: width, height: height)
        shadowRadius = radius
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
