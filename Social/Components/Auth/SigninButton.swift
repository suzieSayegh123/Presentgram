//
//  SigninButton.swift
//  Social
//
//  Created by User on 16/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import Foundation
import SwiftUI

struct SigninButton: View {
    var action: () -> Void
    var label: String
    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Text(label).fontWeight(.bold).foregroundColor(Color.white)
                Spacer()
            }
            }.modifier(SigninButtonModifier()).buttonStyle(GradientBackgroundStyle())
    }
}

struct GradientBackgroundStyle: ButtonStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color(.orange), Color(.purple)]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
            .padding(.horizontal, 20)
    }
}

struct SigninButton_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
