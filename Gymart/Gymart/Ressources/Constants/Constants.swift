//
//  Constants.swift
//  Gymart
//
//  Created by William on 08/06/2019.
//  Copyright © 2019 William Désécot. All rights reserved.
//

import Foundation

struct Constants {
    
    struct App {
        static let mainRegularFont = "DejaVuSans"
        static let mainObliqueFont = "DejaVuSans-Oblique"
    }
    
    struct Placeholder {
        static let userName = "User Name"
        static let email = "Email"
        static let password = "Password"
    }
    
    struct Label {
        static let noTraining = "No training yet for this workout"
    }
    
    struct Alert {
        static let title = "Oups"
        static let okMessage = "Ok"
        
        static let noEmail = "Entrer une adresse email"
    }
    
    struct AlertError {
        static let signOutError = "Sign Out Error"
    }
    
    struct ActionSheet {
        static let signOutAction = "Sign Out"
        static let cancelAction = "Cancel"
    }
}
