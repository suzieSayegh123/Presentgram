//
//  UserApi.swift
//  Social
//
//  Created by User on 18/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import Foundation
import FirebaseAuth

class UserApi {
    func searchUsers(text: String, onSuccess: @escaping(_ user: [User]) -> Void) {
        print(text.lowercased().removingWhitespaces())
        
        Ref.FIRESTORE_COLLECTION_USERS.whereField("keywords", arrayContains: text.lowercased().removingWhitespaces()).getDocuments { (snapshot, error) in
            guard let snap = snapshot else {
                print("Error fetching data")
                return
            }
            print(snap.documents)
            var users = [User]()
            for document in snap.documents {
                    let dict = document.data()
                    guard let decoderUser = try? User.init(fromDictionary: dict) else {return}
                    if decoderUser.uid != Auth.auth().currentUser!.uid {
                        users.append(decoderUser)
                    }
                }
                onSuccess(users)
            }
        }
    
        func loadPosts(userId: String, onSuccess: @escaping(_ posts: [Post]) -> Void) {
           Ref.FIRESTORE_MY_POSTS_DOCUMENT_USERID(userId: userId).collection("userPosts").getDocuments { (snapshot, error) in
           guard let snap = snapshot else {
               print("Error fetching data")
               return
           }
           var posts = [Post]()
           for document in snap.documents {
                   let dict = document.data()
                   guard let decoderPost = try? Post.init(fromDictionary: dict) else {return}
                       posts.append(decoderPost)
                   }
                  onSuccess(posts)
                }
        }
}
               

