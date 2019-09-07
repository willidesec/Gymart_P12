//
//  Workout.swift
//  Gymart
//
//  Created by William on 20/07/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Workout {
    let identifier: String
    let name: String
    let creationDate: Date
    var lastWorkoutDate: Date?
    var exercicesData = [[String: Any]]()
    
    var dictionary: [String: Any] {
        if let lastWorkoutDate = lastWorkoutDate {
            return [
                "id": identifier,
                "name": name,
                "lastWorkoutDate": lastWorkoutDate,
                "creationDate": creationDate,
                "exercices": exercicesData
            ]
        } else {
            return [
                "id": identifier,
                "name": name,
                "creationDate": creationDate,
                "exercices": exercicesData
            ]
        }
    }
    
    init(identifier: String, name: String, creationDate: Date, exercices: [Exercice], lastWorkoutDate: Date? = nil) {
        self.identifier = identifier
        self.name = name
        self.creationDate = creationDate
        self.lastWorkoutDate = lastWorkoutDate
        
        exercices.forEach { (exercice) in
            exercicesData.append(exercice.dictionary)
        }
    }
}

extension Workout: DocumentSerializableProtocol {
    init?(dictionary: [String: Any]) {
        guard let identifier = dictionary["id"] as? String,
            let name = dictionary["name"] as? String else { return nil }
        var date = Date()
        if let creationDate = dictionary["creationDate"] as? Timestamp {
            date = creationDate.dateValue()
        }
        var dateOfWorkout: Date?
        if let lastWorkoutDate = dictionary["lastWorkoutDate"] as? Timestamp {
            dateOfWorkout = lastWorkoutDate.dateValue()
        }
        
        guard let exercicesData = dictionary["exercices"] as? [[String: Any]] else { return nil }
        
        let exercices = exercicesData.compactMap({Exercice(dictionary: $0)})
        
        self.init(identifier: identifier, name: name, creationDate: date, exercices: exercices, lastWorkoutDate: dateOfWorkout)
    }
}
