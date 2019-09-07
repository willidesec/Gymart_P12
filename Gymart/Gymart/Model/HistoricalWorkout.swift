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
    let identifier: String
    let name: String
    let creationDate: Date
    var exercicesData = [[String: Any]]()
    
    var dictionary: [String: Any] {
        return [
            "identifier": identifier,
            "name": name,
            "creationDate": creationDate,
            "exercices": exercicesData
        ]
    }
    
    init(identifier: String, name: String, creationDate: Date, exercices: [HistoricalExercice]) {
        self.identifier = identifier
        self.name = name
        self.creationDate = creationDate
        
        exercices.forEach { (historicalExercice) in
            exercicesData.append(historicalExercice.dictionary)
        }
    }
}

extension HistoricalWorkout: DocumentSerializableProtocol {
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String,
            let identifier = dictionary["identifier"] as? String,
            let creationTimestamp = dictionary["creationDate"] as? Timestamp else { return nil }
        
        let creationDate = creationTimestamp.dateValue()
        
        guard let exercicesData = dictionary["exercices"] as? [[String: Any]] else { return nil }
        
        let exercices = exercicesData.compactMap({HistoricalExercice(dictionary: $0)})
        
        self.init(identifier: identifier, name: name, creationDate: creationDate, exercices: exercices)
    }
}
