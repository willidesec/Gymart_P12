//
//  Workout.swift
//  Gymart
//
//  Created by William on 20/07/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import Foundation
import Firebase

struct Workout {
    let id: String
    let name: String
    let creationDate: Date
    var lastWorkoutDate: Date?
    var exercices = [Exercice]()
    
    var dictionary: [String: Any] {
        if let lastWorkoutDate = lastWorkoutDate {
            return [
                "id": id,
                "name": name,
                "lastWorkoutDate": lastWorkoutDate,
                "creationDate": creationDate
            ]
        } else {
            return [
                "id": id,
                "name": name,
                "creationDate": creationDate
            ]
        }
    }
    
    init(id: String, name: String, creationDate: Date, lastWorkoutDate: Date?) {
        self.id = id
        self.name = name
        self.creationDate = creationDate
        self.lastWorkoutDate = lastWorkoutDate
    }
}

extension Workout: DocumentSerializableProtocol {
    init?(dictionary: [String : Any]) {
        guard let id = dictionary["id"] as? String,
            let name = dictionary["name"] as? String else { return nil }
        var date = Date()
        if let creationDate = dictionary["creationDate"] as? Timestamp {
            date = creationDate.dateValue()
        }
        var dateOfWorkout: Date?
        if let lastWorkoutDate = dictionary["lastWorkoutDate"] as? Timestamp {
            dateOfWorkout = lastWorkoutDate.dateValue()
        }
        
        self.init(id: id, name: name, creationDate: date, lastWorkoutDate: dateOfWorkout)
        
        guard let exercicesData = dictionary["exercices"] as? [[String: Any]] else { return nil }
        
        exercices = exercicesData.compactMap({Exercice(dictionary: $0)})
    }
}
