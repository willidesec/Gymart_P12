//
//  Date+extension.swift
//  Gymart
//
//  Created by William on 03/08/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import Foundation

extension Date {
    var numberOfDaysFromNow: Int {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.day], from: self, to: Date())
            guard let days = components.day else { return 0 }
            return days
    }
}
