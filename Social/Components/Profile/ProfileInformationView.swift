//
//  ProfileInformationView.swift
//  Social
//
//  Created by User on 20/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import SwiftUI

struct ProfileInformation: View {
    var user: User?
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if user != nil {
                Text(user!.username).bold()
                
            }
        }.padding(.leading, 20)
    }
}
