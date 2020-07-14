//
//  Activity.swift
//  Social
//
//  Created by User on 24/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import Foundation



struct Activity: Encodable, Decodable {
    var activityId: String
    var type: String
    var username: String
    var userId: String
    var userAvatar: String
    var postId: String
    var mediaUrl: String
    var comment: String
    var date: Double
    
    var typeDescription: String {
        var output = ""
        switch type {
        case "comment":
            output = "replied: \(comment)"
        case "follow":
            output = "is following you"
        case "like":
            output = "liked your post"
        default:
            output = ""
        }
        
        return output
    }
    

}
