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
    
    var dataBase = Firestore.firestore()
    var collection: CollectionReference?
    
    // MARK: - Init
    
    init() {
        let settings = dataBase.settings
        settings.areTimestampsInSnapshotsEnabled = true
        dataBase.settings = settings
    }
    
    // MARK: - Methods
    
    func fetchPrograms(completion: @escaping FIRQuerySnapshotBlock) {
        collection = dataBase.collection(Endpoint.program.path)
        collection?.order(by: "creationDate", descending: true).getDocuments(completion: completion)
    }
    
    func deleteProgram(identifier: String, completion: @escaping (Error?) -> Void) {
        collection = dataBase.collection(Endpoint.program.path)
        collection?.document(identifier).delete(completion: completion)
    }
    
    func saveDataInFirestore(endpoint: Endpoint, identifier: String, data: [String: Any], completion: @escaping (Error?) -> Void) {
        collection = dataBase.collection(endpoint.path)
        collection?.document(identifier).setData(data, completion: completion)
    }
}

enum Endpoint {
    case program
    case workout
}

extension Endpoint {
    var userId: String {
        guard let currentUser = AuthService.getCurrentUser() else {
            return ""
        }
        return currentUser.uid
    }
    
    var path: String {
        switch self {
        case .program:
            return "users/\(userId)/programs"
        case .workout:
            return "users/currentUser/workout"
        }
    }
}
