//
//  PasswordTextField.swift
//  Social
//
//  Created by User on 16/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import SwiftUI

struct PasswordTextField: View {
    
    @Binding var password: String
    
    var body: some View {
        HStack {
            //password text field
            //Image Icon
            Image(systemName: "lock.fill").foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.3))
            SecureField(TEXT_PASSWORD, text: $password)
        }.modifier(TextFieldModifier())
    }
}
