//
//  ExerciceSet.swift
//  Gymart
//
//  Created by William on 17/08/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import Foundation

struct ExerciceSet {
    let numeroOfSet: Int
    let reps: Int
    let weight: Int
    
    var dictionary: [String: Any] {
        return [
            "numeroOfSet": numeroOfSet,
            "reps": reps,
            "weight": weight
        ]
    }
}

extension ExerciceSet: DocumentSerializableProtocol {
    init?(dictionary: [String : Any]) {
        guard let reps = dictionary["reps"] as? Int,
            let weight = dictionary["weight"] as? Int,
            let numeroOfSet = dictionary["numeroOfSet"] as? Int else { return nil }
        
        self.init(numeroOfSet: numeroOfSet, reps: reps, weight: weight)
    }
    
    
}
