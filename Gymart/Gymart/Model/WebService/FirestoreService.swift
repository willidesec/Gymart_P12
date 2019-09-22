//
//  FirestoreService.swift
//  Gymart
//
//  Created by William on 07/09/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum FirestoreError: Error {
    case offline
}

protocol FirestoreRequest {
    typealias Result = Swift.Result<QuerySnapshot, FirestoreError>
    func fetchCollection(endpoint: Endpoint, result: @escaping (Result) -> Void)
}

final class FirestoreService: FirestoreRequest {
    
    // MARK: - Properties
    
    private var dataBase = Firestore.firestore()
    private var collection: CollectionReference?
    private var document: DocumentReference?
    
    // MARK: - Init
    
    init() {
        let settings = dataBase.settings
        settings.areTimestampsInSnapshotsEnabled = true
        dataBase.settings = settings
    }
    
    // MARK: - Methods
    
    func fetchCollection(endpoint: Endpoint, result: @escaping (FirestoreRequest.Result) -> Void) {
        collection = dataBase.collection(endpoint.path)
        collection?.order(by: "creationDate", descending: true).getDocuments(completion: { (querySnapshot, error) in
            guard let objectData = querySnapshot else {
                result(.failure(.offline))
                return
            }
            result(.success(objectData))
        })
    }
    
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
