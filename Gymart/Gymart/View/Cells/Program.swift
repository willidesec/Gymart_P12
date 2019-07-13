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
    
    init(id: String, name: String, description: String) {
        self.id = id
        self.name = name
        self.description = description
    }
}
