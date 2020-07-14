//
//  Modifiers.swift
//  Social
//
//  Created by User on 16/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.padding()
            .border(COLOR_LIGHT_GRAY, width: 1)
            .padding([.top, .leading, .trailing])
    }
}

struct SigninButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.padding()
            .shadow(radius: 10, x: 0, y: 10).padding()
    }
}


