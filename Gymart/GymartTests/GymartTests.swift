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
    
    var authService = AuthService()
    var firestoreService = FirestoreService()

    override func setUp() {
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchCollectionDataInFirestore() {
        firestoreService.fetchCollectionData(endpoint: .program) { (querySnapShot, error) in
            
        }
    }

}
