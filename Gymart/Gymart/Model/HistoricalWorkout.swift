//
//  HistoricalWorkout.swift
//  Gymart
//
//  Created by William on 17/08/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import Foundation
import FirebaseFirestore

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

extension HistoricalWorkout: DocumentSerializableProtocol {
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String,
        let workoutTimestamp = dictionary["workoutDate"] as? Timestamp else { return nil }
        
        let workoutDate = workoutTimestamp.dateValue()
        
        guard let exercicesData = dictionary["exercices"] as? [[String: Any]] else { return nil }
        
        let exercices = exercicesData.compactMap({HistoricalExercice(dictionary: $0)})
        
        self.init(name: name, workoutDate: workoutDate, exercices: exercices)
    }
}
