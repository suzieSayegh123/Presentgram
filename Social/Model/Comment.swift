//
//  Comment.swift
//  Social
//
//  Created by User on 21/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import Foundation



struct Comment: Encodable, Decodable, Identifiable {
    var id = UUID()
    var comment: String
    var avatarUrl: String
    var ownerId: String
    var postId: String
    var username: String
    var date: Double
    

}
