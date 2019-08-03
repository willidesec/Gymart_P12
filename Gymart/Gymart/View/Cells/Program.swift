//
//  Program.swift
//  Gymart
//
//  Created by William DESECOT on 24/06/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import Foundation
import Firebase

struct Program {
    let id: String
    let name: String
    let description: String
    let creationDate: Date
    
    var dictionary: [String: Any] {
        return [
            "id": id,
            "name": name,
            "description": description,
            "creationDate": creationDate
        ]
    }
}

extension Program: DocumentSerializableProtocol {
    init?(dictionary: [String : Any]) {
        guard let id = dictionary["id"] as? String,
            let name = dictionary["name"] as? String,
            let description = dictionary["description"] as? String else { return nil }
        var date = Date()
        if let creationDate = dictionary["creationDate"] as? Timestamp {
            date = creationDate.dateValue()
        }
        
        self.init(id: id, name: name, description: description, creationDate: date)
    }
}

