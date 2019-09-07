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
    var document: DocumentReference?
    
    // MARK: - Init
    
    init() {
        let settings = dataBase.settings
        settings.areTimestampsInSnapshotsEnabled = true
        dataBase.settings = settings
    }
    
    // MARK: - Methods
    
    func fetchCollectionData(endpoint: Endpoint, completion: @escaping FIRQuerySnapshotBlock) {
        collection = dataBase.collection(endpoint.path)
        collection?.order(by: "creationDate", descending: true).getDocuments(completion: completion)
    }
    
    func fetchDocumentData(endpoint: Endpoint, completion: @escaping FIRDocumentSnapshotBlock) {
        document = dataBase.document(endpoint.path)
        document?.getDocument(completion: completion)
    }
    
    func deleteDocumentData(endpoint: Endpoint, identifier: String, completion: @escaping (Error?) -> Void) {
        collection = dataBase.collection(endpoint.path)
        collection?.document(identifier).delete(completion: completion)
    }
    
    func saveDataInFirestore(endpoint: Endpoint, identifier: String, data: [String: Any], completion: @escaping (Error?) -> Void) {
        collection = dataBase.collection(endpoint.path)
        collection?.document(identifier).setData(data, completion: completion)
    }
    
    func updateDocumentDataInFirestore(endpoint: Endpoint, data: [String: Any], completion: @escaping (Error?) -> Void) {
        document = dataBase.document(endpoint.path)
        document?.updateData(data, completion: completion)
    }
}

enum Endpoint {
    case user
    case program
    case workout(programId: String)
    case training(programId: String, workoutId: String)
    case historical
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
        case .user:
            return "users/\(userId)"
        case .program:
            return "users/\(userId)/programs"
        case let .workout(programId):
            return "users/\(userId)/programs/\(programId)/workouts"
        case let .training(programId, workoutId):
            return "users/\(userId)/programs/\(programId)/workouts/\(workoutId)"
        case .historical:
            return "users/\(userId)/historical"
        }
    }
}
