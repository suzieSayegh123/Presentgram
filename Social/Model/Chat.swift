//
//  Chat.swift
//  Social
//
//  Created by User on 22/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import Foundation
import FirebaseAuth


struct Chat: Encodable, Decodable {
    var messageId: String
    var textMessage: String
    var avatarUrl: String
    var photoUrl: String
    var senderId: String
    var username: String
    var date: Double
    var type: String
    
    var isCurrentUser: Bool {
        return Auth.auth().currentUser!.uid == senderId
    }
    var isPhoto: Bool {
        return type == "PHOTO"
    }
    var isTextMesaage: Bool {
        return type == "TEXT"
    }

}
