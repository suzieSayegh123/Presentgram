//
//  ContentView.swift
//  Social
//
//  Created by User on 16/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import SwiftUI
import Foundation
import UIKit

struct SigninView: View {
    
    
    
    
    @ObservedObject var signinViewModel = SigninViewModel()
    
    
    
    func signIn() {
        
        
        signinViewModel.signin(email: signinViewModel.email, password: signinViewModel.password, completed: { (user) in
            print("login: \(user.email)")
        }) { (errorMessage) in
            print("Error: \(errorMessage)")
            self.signinViewModel.showAlert = true
            self.signinViewModel.errorString = errorMessage
            self.clean()
        }
        
    }
    
    func clean() {
        self.signinViewModel.email = ""
        self.signinViewModel.password = ""
    }
    
    
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
            
                Spacer()
                
                
                           
                    HeaderView()
                           
                Spacer()
                           
                    Divider()
                           
                EmailTextField(email: $signinViewModel.email)
            
                PasswordTextField(password: $signinViewModel.password)
                           
                SigninButton(action: signIn, label: TEXT_SIGN_IN).alert(isPresented: $signinViewModel.showAlert) {
                        Alert(title: Text("Error"), message: Text(self.signinViewModel.errorString), dismissButton: .default(Text("OK")))
                }
                           
                    Divider()
                
                NavigationLink(destination: SignupView()) {
                    
                    SignupText()
                    
                }
            }
        }
    }
}




struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
    
        
    }
}















