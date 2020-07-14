//
//  EditProfileButton.swift
//  Social
//
//  Created by User on 20/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import SwiftUI


struct EditProfileButton: View {
    var body: some View {
        Button(action: {}) {
            HStack {
                Spacer()
                Text("Edit Profile").fontWeight(.bold).foregroundColor(Color.white)
                Spacer()
            }.frame(height: 30).background(Color.black)
            
        }.cornerRadius(5).padding(.leading, 20).padding(.trailing, 20)
    }
}
