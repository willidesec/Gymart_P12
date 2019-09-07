//
//  AuthService.swift
//  Gymart
//
//  Created by William on 13/07/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthService {
    
    static func getCurrentUser() -> User? {
        let currentUser = Auth.auth().currentUser
        
        if let currentUser = currentUser {
            return currentUser
        } else {
            return nil
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: completion)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
}
