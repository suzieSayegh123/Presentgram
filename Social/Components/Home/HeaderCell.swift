//
//  HeaderCell.swift
//  Social
//
//  Created by User on 18/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import SwiftUI
import URLImage

struct HeaderCell: View {
    
    var post: Post
    
    var body: some View {
        VStack {
            HStack {
                URLImage(URL(string: post.avatar)!,
                    content: {
                        $0.image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                    }).frame(width: 35, height: 35)
                    VStack(alignment: .leading) {
                        Text(post.username).font(.subheadline).bold()
                        
                    }
                    Spacer()
                }.padding(.trailing, 15).padding(.leading, 15)
                
            URLImage(URL(string: post.mediaUrl)!,
            content: {
                $0.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }).frame(width: UIScreen.main.bounds.size.width, height: 300).clipped()
        }
    
    }
}


