//
//  UIFont+extension.swift
//  Gymart
//
//  Created by William on 08/06/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit

extension UIFont {
    
    class func mainRegularFont(size: CGFloat) -> UIFont {
        return UIFont(name: Constants.App.mainRegularFont, size: size)!
    }
    
    class func mainObliqueFont(size: CGFloat) -> UIFont {
        return UIFont(name: Constants.App.mainObliqueFont, size: size)!
    }
}
