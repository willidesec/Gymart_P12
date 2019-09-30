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
    typealias FirestoreUpdateResult = Result<String, FirestoreError>
    
    func fetchCollection(endpoint: Endpoint, result: @escaping (FirestoreCollectionResult<FirestoreObject>) -> Void)
    func fetchDocument(endpoint: Endpoint, result: @escaping (FirestoreDocumentResult<FirestoreObject>) -> Void)
    func saveData(endpoint: Endpoint, identifier: String, data: [String: Any], result: @escaping (FirestoreUpdateResult) -> Void)
    func deleteDocumentData(endpoint: Endpoint, identifier: String, result: @escaping (FirestoreUpdateResult) -> Void)
    func updateData(endpoint: Endpoint, data: [String: Any], result: @escaping (FirestoreUpdateResult) -> Void)
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
    
    public func saveData(endpoint: Endpoint, identifier: String, data: [String: Any], result: @escaping (FirestoreUpdateResult) -> Void) {
        collection = dataBase.collection(endpoint.path)
        collection?.document(identifier).setData(data, completion: { (error) in
            if let error = error {
                print("Error adding document: \(error)")
                result(.failure(.offline))
            } else {
                result(.success("Document added with success"))
            }
        })
    }
    
    public func deleteDocumentData(endpoint: Endpoint, identifier: String, result: @escaping (FirestoreUpdateResult) -> Void) {
        collection = dataBase.collection(endpoint.path)
        collection?.document(identifier).delete(completion: { error in
            if let error = error {
                print("Error deleting document: \(error)")
                result(.failure(.offline))
            } else {
                result(.success("Document deleted with success"))
            }
        })
    }
    
    public func updateData(endpoint: Endpoint, data: [String: Any], result: @escaping (FirestoreUpdateResult) -> Void) {
        document = dataBase.document(endpoint.path)
        document?.updateData(data, completion: { error in
            if let error = error {
                print("Error updating document: \(error)")
                result(.failure(.offline))
            } else {
                result(.success("Document updated with success"))
            }
        })
    }
}
