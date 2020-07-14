//
//  PostPopularViewModel.swift
//  Social
//
//  Created by User on 21/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import Foundation
import SwiftUI

class PostPopularViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    var splitted: [[Post]] = []
    
    func loadPostPopular() {
        isLoading = true
        Api.Post.loadPosts() { (posts) in
            self.isLoading = false
            self.posts = posts
            self.splitted = self.posts.splited(into: 3)
        }
    }
    
}
