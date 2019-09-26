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

private class FirestoreServiceSpy: FirestoreRequest {
    
    var message: ((FirestoreRequest.Result) -> Void)?
    
    func fetchCollection(endpoint: Endpoint, result: @escaping (FirestoreRequest.Result) -> Void) {
        message = result
    }
    
    func completeRequestSuccessfullyWith() {
        message?(.success)
    }
    
}
