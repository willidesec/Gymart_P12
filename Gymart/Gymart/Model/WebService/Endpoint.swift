//
//  Endpoint.swift
//  Gymart
//
//  Created by William on 08/09/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import Foundation

public enum Endpoint {
    case user
    case currentUser
    case program
    case workout(programId: String)
    case training(programId: String, workoutId: String)
    case historical
}

extension Endpoint {
    var userId: String {
        guard let currentUser = AuthService.getCurrentUser() else {
            return "unknow user"
        }
        return currentUser.uid
    }
    
    var path: String {
        switch self {
        case .user:
            return "users"
        case .currentUser:
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
