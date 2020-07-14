//
//  MessagesViewModel.swift
//  Social
//
//  Created by User on 23/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseStorage
import SwiftUI


class MessageViewModel: ObservableObject {
    
    
    @Published var inboxMessages: [InboxMessage] = [InboxMessage]()
    
    var listener: ListenerRegistration!
    
    init() {
        loadInboxMessages()
    }
    
    func  loadInboxMessages() {
        self.inboxMessages = []
        
        
        Api.Chat.getInboxMessages(onSuccess: { (inboxMessages) in
            if self.inboxMessages.isEmpty {
                self.inboxMessages = inboxMessages
            }
        }, onError: { (errorMessage) in

        }, newInboxMessage: { (inboxMessage) in
            if !self.inboxMessages.isEmpty {
                self.inboxMessages.append(inboxMessage)
            }
        }) { (listener) in
            self.listener = listener
        }
        
    }
}
