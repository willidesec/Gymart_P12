//
//  HistoricalExercice.swift
//  Gymart
//
//  Created by William on 17/08/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import Foundation

struct HistoricalExercice {
    let name: String
    var setsData = [[String: Any]]()
    
    var dictionary: [String: Any] {
        return [
            "name": name,
            "sets": setsData
        ]
    }
    
    init(name: String, sets: [ExerciceSet]) {
        self.name = name
        
        sets.forEach { (exerciceSet) in
            setsData.append(exerciceSet.dictionary)
        }
    }
}

extension HistoricalExercice: DocumentSerializableProtocol {
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String else { return nil }
        
        guard let setsData = dictionary["sets"] as? [[String: Any]] else { return nil }
        
        let sets = setsData.compactMap({ExerciceSet(dictionary: $0)})
        
        self.init(name: name, sets: sets)
    }
    
}
