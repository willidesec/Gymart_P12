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
        static let mainCondensedBoldFont = "DejaVuSansCondensed-Bold"
    }
    
    struct Navigation {
        static let trainingTitle = "Training"
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
        
        static let noEmail = "Enter an email"
        static let noPassword = "Enter a password"
        static let noUserName = "Enter a User Name"
    }
    
    struct AlertError {
        static let signOutError = "Sign Out Error"
    }
    
    struct ActionSheet {
        static let signOutAction = "Sign Out"
        static let cancelAction = "Cancel"
    }
    
    struct FooterView {
        static let noExercices = "No exercices yet\n Add some 🏋🏻‍♂️"
    }
}
