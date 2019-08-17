//
//  HistoricalWorkout.swift
//  Gymart
//
//  Created by William on 17/08/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import Foundation

struct HistoricalWorkout {
    let name: String
    let workoutDate: Date
    var exercicesData = [[String: Any]]()
    
    var dictionary: [String: Any] {
        return [
            "name": name,
            "workoutDate": workoutDate,
            "exercices": exercicesData
        ]
    }
    
    init(name: String, workoutDate: Date, exercices: [HistoricalExercice]) {
        self.name = name
        self.workoutDate = workoutDate
        
        exercices.forEach { (historicalExercice) in
            exercicesData.append(historicalExercice.dictionary)
        }
    }
}
