//
//  FirestoreService.swift
//  Gymart
//
//  Created by William on 07/09/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import Foundation
import FirebaseFirestore

final class FirestoreService {
    
    // MARK: - Properties
    
    var dataBase: Firestore
    let userId: String
    
    // MARK: - Init
    
    init() {
        self.dataBase = Firestore.firestore()
        let settings = dataBase.settings
        settings.areTimestampsInSnapshotsEnabled = true
        dataBase.settings = settings
        
        guard let currentUser = AuthService.getCurrentUser() else {
            self.userId = ""
            return
        }
        self.userId = currentUser.uid
    }
    
    // MARK: - Methods
    
    func fetchPrograms(completion: @escaping FIRQuerySnapshotBlock ) {
        let programsCollection = dataBase.collection(Endpoint.program(userId: userId).path)
        programsCollection.order(by: "creationDate", descending: true).getDocuments(completion: completion)
    }
    
}

enum Endpoint {
    case program(userId: String)
    case workout
}

extension Endpoint {
    var path: String {
        switch self {
        case let .program(userId):
            return "users/\(userId)/programs"
        case .workout:
            return "user/currentUser/workout"
        }
    }
}
