//
//  ProfileViewModel.swift
//  Social
//
//  Created by User on 20/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var followingCountState = 0
    @Published var followersCountState = 0
    
    var splitted: [[Post]] = []
    
    
    @Published var isFollowing = false
    
    func checkFollowState(userId: String) {
        Ref.FIRESTORE_COLLECTION_FOLLOWERS_USERID(userId: userId).getDocument { (document, error) in
            if let doc = document, doc.exists {
                self.isFollowing = true
            } else {
                self.isFollowing = false
            }
        }
    }
    
    func loadUserPosts(userId: String) {
        isLoading = true
        Api.User.loadPosts(userId: userId) { (posts) in
            self.isLoading = false
            self.posts = posts
            self.splitted = self.posts.splited(into: 3)
        }
    }
    
    func updateFollowCount(userId: String) {
        Ref.FIRESTORE_COLLECTION_FOLLOWING(userId: userId).getDocuments { (snapshot, error) in
            if let doc = snapshot?.documents {
                self.followingCountState = doc.count
            }
        }
        
        Ref.FIRESTORE_COLLECTION_FOLLOWERS(userId: userId).getDocuments { (snapshot, error) in
            if let doc = snapshot?.documents {
                self.followersCountState = doc.count
            }
        }
    }
    
}

