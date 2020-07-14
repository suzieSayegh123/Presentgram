//
//  SignInViewModel.swift
//  Social
//
//  Created by User on 17/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseStorage
import SwiftUI


class SigninViewModel: ObservableObject {
    

    
    var email: String = ""
    var password: String = ""
    
    var errorString = ""
    
    @Published var showAlert: Bool = false
    
    
    func signin(email: String, password: String, completed: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        if !email.isEmpty && !password.isEmpty {
            
            AuthService.signInUser(email: email, password: password, onSuccess: completed, onError: onError)
        } else {
            showAlert = true
            errorString = "Please fill in all fields"
        }
        
    }
    
   
}

