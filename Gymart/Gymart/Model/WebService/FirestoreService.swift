//
//  FirestoreService.swift
//  Gymart
//
//  Created by William on 07/09/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import Foundation
import FirebaseFirestore

public enum FirestoreError: Error {
    case offline
}

public protocol FirestoreRequest {
    associatedtype FirestoreObject: DocumentSerializableProtocol
    typealias FirestoreResult<FirestoreObject: DocumentSerializableProtocol> = Result<[FirestoreObject], FirestoreError>
    func fetchCollection(endpoint: Endpoint, result: @escaping (FirestoreResult<FirestoreObject>) -> Void)
}

final public class FirestoreServiceGeneric<FirestoreObject: DocumentSerializableProtocol>: FirestoreRequest {
    
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
    
    public func fetchCollection(endpoint: Endpoint, result: @escaping (FirestoreResult<FirestoreObject>) -> Void) {
        collection = dataBase.collection(endpoint.path)
        collection?.order(by: "creationDate", descending: true).getDocuments(completion: { (querySnapshot, error) in
            if error != nil {
                result(.failure(.offline))
            }
            
            guard let objectData = querySnapshot else {
                result(.failure(.offline))
                return
            }
            let object = objectData.documents.compactMap({FirestoreObject(dictionary: $0.data())})
            result(.success(object))
        })
    }
}

final public class FirestoreService {
    
    private var dataBase = Firestore.firestore()
    private var collection: CollectionReference?
    private var document: DocumentReference?
    
    init() {
        let settings = dataBase.settings
        settings.areTimestampsInSnapshotsEnabled = true
        dataBase.settings = settings
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
