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
    typealias FirestoreCollectionResult<FirestoreObject: DocumentSerializableProtocol> = Result<[FirestoreObject], FirestoreError>
    typealias FirestoreDocumentResult<FirestoreObject: DocumentSerializableProtocol> = Result<FirestoreObject, FirestoreError>
    
    func fetchCollection(endpoint: Endpoint, result: @escaping (FirestoreCollectionResult<FirestoreObject>) -> Void)
    func fetchDocument(endpoint: Endpoint, result: @escaping (FirestoreDocumentResult<FirestoreObject>) -> Void)
}

final public class FirestoreService<FirestoreObject: DocumentSerializableProtocol>: FirestoreRequest {
    
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
    
    public func fetchCollection(endpoint: Endpoint, result: @escaping (FirestoreCollectionResult<FirestoreObject>) -> Void) {
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
    
    public func fetchDocument(endpoint: Endpoint, result: @escaping (FirestoreDocumentResult<FirestoreObject>) -> Void) {
        document = dataBase.document(endpoint.path)
        document?.getDocument(completion: { (documentSnapshot, error) in
            if error != nil {
                result(.failure(.offline))
            }
            
            guard let objectData = documentSnapshot, objectData.exists else {
                result(.failure(.offline))
                return
            }
            guard let object = objectData.data().map({FirestoreObject(dictionary: $0)}) as? FirestoreObject else { return }
            result(.success(object))
        })
    }
}

final public class FirestoreServiceOld {
    
    private var dataBase = Firestore.firestore()
    private var collection: CollectionReference?
    private var document: DocumentReference?
    
    init() {
        let settings = dataBase.settings
        settings.areTimestampsInSnapshotsEnabled = true
        dataBase.settings = settings
    }
    
//    func fetchCollectionData(endpoint: Endpoint, completion: @escaping FIRQuerySnapshotBlock) {
//        collection = dataBase.collection(endpoint.path)
//        collection?.order(by: "creationDate", descending: true).getDocuments(completion: completion)
//    }
//    
//    func fetchDocumentData(endpoint: Endpoint, completion: @escaping FIRDocumentSnapshotBlock) {
//        document = dataBase.document(endpoint.path)
//        document?.getDocument(completion: completion)
//    }
    
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
