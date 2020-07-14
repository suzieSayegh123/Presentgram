//
//  SignupView.swift
//  Social
//
//  Created by User on 16/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import SwiftUI

struct SignupText: View {
    var body: some View {
        HStack {
            Text(TEXT_NEED_AN_ACCOUNT).font(.footnote).foregroundColor(.gray)
            Text(TEXT_SIGN_UP).foregroundColor(.black)
        }
    }
}
