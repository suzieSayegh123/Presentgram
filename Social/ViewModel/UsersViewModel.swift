//
//  UsersViewModel.swift
//  Social
//
//  Created by User on 18/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import Foundation
import SwiftUI

class UsersViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    var searchText: String = ""
    
    func searchTextDidChange() {
        isLoading = true
        //Api.User.searchUsers(text: searchText)
        Api.User.searchUsers(text: searchText) { (users) in
            self.isLoading = false
            self.users = users
        }
    }
    
}
