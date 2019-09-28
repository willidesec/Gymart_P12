//
//  GymartTests.swift
//  GymartTests
//
//  Created by William on 15/09/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import XCTest
import Firebase
@testable import Gymart_PP

class GymartTests: XCTestCase {
    
    let authService = AuthService()

    override func setUp() {
        authService.signIn(email: "unitTests@test.fr", password: "azerty") { (_, error) in
            if error != nil {
                print("Fail")
            }
        }
    }

    override func tearDown() {
        do {
            try authService.signOut()
        } catch let error {
            print(error.localizedDescription)
        }
    }

//    func testFetchCollectionSuccessfully() {
//        let firestoreServiceSpy = FirestoreServiceSpy<Program>()
//        let programs = [Program]()
//
//        let exp = expectation(description: "Wait for load completion")
//
//        firestoreServiceSpy.fetchCollection(endpoint: .program) { result in
//            switch result {
//            case .success(let receivedPrograms):
//                XCTAssertEqual(receivedPrograms, programs)
//            case .failure:
//                XCTFail("Should be success, got \(result) instead")
//            }
//        }
//    }
    
    func testFetchDocumentSuccessfully() {
        let firestoreServiceSpy = FirestoreServiceSpy<Profil>()
        let profil = Profil(identifier: "yblp54LyxzLYhFYqjP3e06AJxAv1", email: "unitTests@test.fr", userName: "Unit Tests")
        
        let exp = expectation(description: "Wait for load completion")
        
        firestoreServiceSpy.fetchDocument(endpoint: .currentUser) { result in
            switch result {
            case let .success(receivedProfil):
                XCTAssertEqual(receivedProfil, profil)
            case .failure(.offline):
                XCTFail("Should be success, got \(result) instead")
            }
            exp.fulfill()
        }
        firestoreServiceSpy.fetchDocumentSuccessfullyWith(profil)
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func testFetchDocumentWithOfflineError() {
        let firestoreServiceSpy = FirestoreServiceSpy<Profil>()
        
        let exp = expectation(description: "Wait for load completion")
        
        firestoreServiceSpy.fetchDocument(endpoint: .currentUser) { result in
            switch result {
            case .success:
                XCTFail("Should fail, got \(result) instead")
            case .failure(let receivedError):
                XCTAssertEqual(receivedError, .offline)
            }
            exp.fulfill()
        }
        
        firestoreServiceSpy.fetchDocumentWithOfflineError()
        
        wait(for: [exp], timeout: 1.0)
    }
    
//    func testFirestore() {
//        let firestoreService = FirestoreService<Profil>()
//        let profil = Profil(identifier: "yblp54LyxzLYhFYqjP3e06AJxAv1", email: "unitTests@test.fr", userName: "Unit Tests")
//
//        let exp = expectation(description: "Wait for load completion")
//
//        firestoreService.fetchDocument(endpoint: .currentUser) { (result) in
//            switch result {
//            case .success(let receivedProfil):
//                XCTAssertEqual(receivedProfil, profil)
//            case .failure:
//                XCTFail("Should be success, got \(result) instead")
//            }
//            exp.fulfill()
//        }
//
//        wait(for: [exp], timeout: 1.0)
//    }

}
