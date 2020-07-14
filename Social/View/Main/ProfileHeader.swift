//
//  ProfileHeader.swift
//  Social
//
//  Created by User on 18/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import SwiftUI
import URLImage

struct ProfileHeader: View {
    var user: User?
    var postCount: Int
    @Binding var followingCount: Int
    @Binding var followersCount: Int
    var body: some View {
        HStack {
            if user != nil {
                URLImage(URL(string: user!.profileImageUrl)!,
                    content: {
                        $0.image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                    }).frame(width: 80, height: 80).padding(.leading, 20)
                    
                    Spacer()
                    VStack {
                        Text("\(postCount)").font(.headline)
                        Text("Posts").font(.subheadline)
                    }.padding(10)
                    VStack {
                        Text("\(followersCount)").font(.headline)
                        Text("Followers").font(.subheadline)
                    }.padding(10)
//              
                    Spacer()
                }
            }
    }
}

//struct ProfileHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileHeader()
//    }
//}
