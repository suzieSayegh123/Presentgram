//
//  Story.swift
//  Social
//
//  Created by User on 24/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import SwiftUI

struct Story: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 22) {
                ForEach(1..<100) { _ in
                    VStack {
                        Image("present").resizable().aspectRatio(contentMode: ContentMode.fill).frame(width: 50, height: 50)
                    }
                }
            }.padding(.top, 10).padding(.leading, 15)
        }.frame( height: 90)
    }
}


