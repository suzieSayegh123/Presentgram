//
//  UserView.swift
//  Social
//
//  Created by User on 18/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import SwiftUI
import URLImage

struct UsersView: View {
    
    @ObservedObject var usersViewModel = UsersViewModel()


    var body: some View {
                VStack {
                    SearchBar(text: $usersViewModel.searchText, onSearchButtonChanged: usersViewModel.searchTextDidChange)

                    List {
                        if !usersViewModel.isLoading {

                            ForEach(usersViewModel.users, id: \.uid) { user in
                                NavigationLink(destination: UserProfileView(user: user)) {
                                    HStack {
                                    URLImage(URL(string: user.profileImageUrl)!,
                                    content: {
                                        $0.image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .clipShape(Circle())
                                    }).frame(width: 50, height: 50)
                                        VStack(alignment: .leading, spacing: 5) {
                                         Text(user.username).font(.headline).bold()
                                            
                                        }
                                      
                                    }.padding(10)
                                }
                           }
                        }
                   
                   
                    }
                }.navigationBarTitle(Text("Search"), displayMode: .inline)
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}

