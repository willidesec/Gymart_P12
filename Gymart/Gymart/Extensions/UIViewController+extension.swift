//
//  UIViewController+extension.swift
//  Gymart
//
//  Created by William on 09/06/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import UIKit

extension UIViewController {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


