//
//  Post.swift
//  Social
//
//  Created by User on 20/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import Foundation



struct Post: Encodable, Decodable {
    var caption: String
    var likes: [String: Bool]
    var ownerId: String
    var postId: String
    var username: String
    var avatar: String
    var mediaUrl: String
    var date: Double
    var likeCount: Int
    

}
