//
//  UsernameTextField.swift
//  Social
//
//  Created by User on 16/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import SwiftUI

struct UsernameTextField: View {
    @Binding var username: String
    
    var body: some View {
        HStack {
            //email text field
            //Image Icon
            Image(systemName: "person.fill").foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.3))
            TextField(TEXT_USERNAME, text: $username)
        }.modifier(TextFieldModifier())
    }
}

