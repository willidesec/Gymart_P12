//
//  Exercice.swift
//  Gymart
//
//  Created by William on 21/07/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import Foundation

struct Exercice {
    let name: String
    let sets: Int
    
    var dictionary: [String: Any] {
        return [
            "name": name,
            "sets": sets
        ]
    }
}

extension Exercice: DocumentSerializableProtocol {
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String,
            let sets = dictionary["sets"] as? Int else { return nil }
        
        self.init(name: name, sets: sets)
    }
}
