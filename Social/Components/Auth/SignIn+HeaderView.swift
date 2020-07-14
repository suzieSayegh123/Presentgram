//
//  SignIn+HeaderView.swift
//  Social
//
//  Created by User on 16/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        Group {
            
            
            
            //Image Icon
            Image(IMAGE_LOGO).resizable().aspectRatio(contentMode: .fill).frame(width: 80, height: 80)
            
            //headline text
            Text(TEXT_SIGNIN_HEADLINE).font(Font.title).padding(.bottom)
            //subheahed line text
            
            Text(TEXT_SIGNIN_SUBHEADLINE)
                .font(Font.subheadline)
                .foregroundColor(Color.gray).multilineTextAlignment(TextAlignment.center)
        }
    }
}
