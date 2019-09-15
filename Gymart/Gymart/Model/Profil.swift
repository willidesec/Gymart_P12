//
//  Profil.swift
//  Gymart
//
//  Created by William on 07/09/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import Foundation

struct Profil {
    let identifier: String
    let email: String
    let userName: String

    var dictionary: [String: Any] {
        return [
            "userId": identifier,
            "email": email,
            "userName": userName
        ]
    }
}

extension Profil: DocumentSerializableProtocol {
    init?(dictionary: [String: Any]) {
        guard let identifier = dictionary["userId"] as? String,
            let email = dictionary["email"] as? String,
            let userName = dictionary["userName"] as? String else { return nil }
        
        self.init(identifier: identifier, email: email, userName: userName)
    }
}
