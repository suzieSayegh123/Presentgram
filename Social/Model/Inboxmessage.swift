//
//  Inboxmessage.swift
//  Social
//
//  Created by User on 22/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import Foundation



struct InboxMessage: Encodable, Decodable, Identifiable {
    var id = UUID()
    var lastMessage: String
    var username: String
    var type: String
    var date: Double
    var userId: String
    var avatarUrl: String
    

}
