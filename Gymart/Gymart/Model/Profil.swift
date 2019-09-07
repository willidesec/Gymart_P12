//
//  Profil.swift
//  Gymart
//
//  Created by William on 07/09/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import Foundation

struct Profil {
    let id: String
    let email: String
    let userName: String

    var dictionary: [String: Any] {
        return [
            "id": id,
            "email": email,
            "userName": userName
        ]
    }
}

extension Profil: DocumentSerializableProtocol {
    init?(dictionary: [String : Any]) {
        guard let id = dictionary["userId"] as? String,
            let email = dictionary["email"] as? String,
            let userName = dictionary["userName"] as? String else { return nil }
        
        self.init(id: id, email: email, userName: userName)
    }
}
