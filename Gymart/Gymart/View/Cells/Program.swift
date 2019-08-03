//
//  Program.swift
//  Gymart
//
//  Created by William DESECOT on 24/06/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import Foundation

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
            let description = dictionary["description"] as? String,
            let creationDate = dictionary["creationDate"] as? Date else { return nil }
        
        self.init(id: id, name: name, description: description, creationDate: creationDate)
    }
}

