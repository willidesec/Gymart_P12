//
//  FirestoreServiceSpy.swift
//  GymartTests
//
//  Created by William DESECOT on 23/09/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import Foundation
import Firebase
@testable import Gymart_PP

class FirestoreServiceSpy<FirestoreObject: DocumentSerializableProtocol>: FirestoreRequest {
    func saveData(endpoint: Endpoint, identifier: String, data: [String : Any], result: @escaping (FirestoreUpdateResult) -> Void) {
        
    }
    
    func deleteDocumentData(endpoint: Endpoint, identifier: String, result: @escaping (FirestoreUpdateResult) -> Void) {
        
    }
    
    func updateData(endpoint: Endpoint, data: [String : Any], result: @escaping (FirestoreUpdateResult) -> Void) {
        
    }
    
    
    var collectionMessage: ((FirestoreCollectionResult<FirestoreObject>) -> Void)?
    var documentMessage: ((FirestoreDocumentResult<FirestoreObject>) -> Void)?
    
    // MARK: - Protocol Methods
    
    func fetchCollection(endpoint: Endpoint, result: @escaping (Result<[FirestoreObject], FirestoreError>) -> Void) {
        collectionMessage = result
    }
    
    func fetchDocument(endpoint: Endpoint, result: @escaping (Result<FirestoreObject, FirestoreError>) -> Void) {
        documentMessage = result
    }
    
    // MARK: - Helpers Methods
    
    func fetchCollectionSuccessfullyWith(_ firestoreObject: [FirestoreObject]) {
        collectionMessage?(.success(firestoreObject))
    }
    
    func fetchCollectionWithOfflineError() {
        collectionMessage?(.failure(.offline))
    }
    
    func fetchDocumentSuccessfullyWith(_ firestoreObject: FirestoreObject) {
        documentMessage?(.success(firestoreObject))
    }
    
    func fetchDocumentWithOfflineError() {
        documentMessage?(.failure(.offline))
    }
}
