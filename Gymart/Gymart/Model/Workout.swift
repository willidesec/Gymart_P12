//
//  Workout.swift
//  Gymart
//
//  Created by William on 20/07/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import Foundation

struct Workout {
    let id: String
    let name: String
    var lastWorkoutDate: Date?
    var exercices = [Exercice]()
    
    init(id: String, name: String, lastWorkoutDate: Date?) {
        self.id = id
        self.name = name
        self.lastWorkoutDate = lastWorkoutDate
    }
}
