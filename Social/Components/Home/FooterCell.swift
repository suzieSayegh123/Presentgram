//
//  FooterCell.swift
//  Social
//
//  Created by User on 18/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import SwiftUI
import URLImage

struct FooterCell: View {
    
    @ObservedObject var footerCellViewModel = FooterCellViewModel()
    
    init(post: Post) {
        self.footerCellViewModel.post = post
        self.footerCellViewModel.checkPostIsLiked()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: (self.footerCellViewModel.isLiked) ? "heart.fill" : "heart").onTapGesture {
                    if self.footerCellViewModel.isLiked {
                        self.footerCellViewModel.unlike()
                    } else {
                        self.footerCellViewModel.like()
                    }
                }
                NavigationLink(destination: CommentView(post: self.footerCellViewModel.post)) {
                    Image(systemName: "bubble.left").renderingMode(.original)
                }
                
                Spacer()
            }.padding(.trailing, 15).padding(.leading, 15)
            
            if footerCellViewModel.post.likeCount > 0 {
                Text("\(footerCellViewModel.post.likeCount) \(self.footerCellViewModel.post.likeCount > 1 ? "likes" : "like")").font(.caption).foregroundColor(.gray).padding(.leading, 15).padding(.top, 5)
            }
            
            HStack {
                Text(self.footerCellViewModel.post.username).font(.subheadline).bold()
                Text(self.footerCellViewModel.post.caption).font(.subheadline)
            }.padding(.leading, 15)
        
            NavigationLink(destination: CommentView(post: self.footerCellViewModel.post)) {
                    Text("View all comments").font(.caption).foregroundColor(.gray).padding(.leading, 15).accentColor(.red)
                }
            
            
            HStack {
                URLImage(URL(string: self.footerCellViewModel.post.avatar)!,
                content: {
                    $0.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                })
                .frame(width: 25, height: 25)
                
            }.padding(.trailing, 15).padding(.leading, 15)
            Text(timeAgoSinceDate(Date(timeIntervalSince1970: self.footerCellViewModel.post.date), currentDate: Date(), numericDates: true)).font(.caption).foregroundColor(.gray).padding(.leading, 15)

            
        }
    
    }
}


struct FooterCell_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
