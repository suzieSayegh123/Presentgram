//
//  ChatViewModel.swift
//  Social
//
//  Created by User on 22/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseStorage
import SwiftUI


class ChatViewModel: ObservableObject {
    
    @Published var composedMessages: String = ""
    var imageData: Data = Data()
    var errorString = ""
    var image: Image = Image(systemName: IMAGE_PHOTO)
    
    @Published var showAlert: Bool = false
    @Published var showImagePicker: Bool = false
    
    @Published var chatArray: [Chat] = []
    @Published var isLoading = false
    var repicientId = ""
    var listener: ListenerRegistration!
    
    func  loadChatMessages() {
        self.chatArray = []
        self.isLoading = true
        
        
        Api.Chat.getChatMessages(withUser: repicientId, onSuccess: { (chatMessages) in
            if self.chatArray.isEmpty {
                self.chatArray = chatMessages
            }
        }, onError: { (errorMessage) in
            
        }, newChatMessage: { (chat) in
            if !self.chatArray.isEmpty {
                self.chatArray.append(chat)
            }
        }) { (listener) in
            self.listener = listener
        }
        
    }
    
    func sendTextMessage(recipientId: String,recipientAvatarUrl: String, recipientUsername: String, completed: @escaping() -> Void,  onError: @escaping(_ errorMessage: String) -> Void) {
        if !composedMessages.isEmpty {
            Api.Chat.sendMessages(message: composedMessages, recipientId: recipientId, recipientAvatarUrl: recipientAvatarUrl, recipientUsername: recipientUsername, onSuccess: completed, onError: onError)
                  } else {
                      showAlert = true
                      errorString = "Please fill in all fields"
                  }
    }
    
    
    func sendPhotoMessage(recipientId: String,recipientAvatarUrl: String, recipientUsername: String,completed: @escaping() -> Void,  onError: @escaping(_ errorMessage: String) -> Void) {
        if !imageData.isEmpty {
            Api.Chat.sendPhotoMessages(recipientId: recipientId, recipientAvatarUrl: recipientAvatarUrl, recipientUsername: recipientUsername, imageData: imageData, onSuccess: completed, onError: onError)
            } else {
                 showAlert = true
                 errorString = "Please fill in all fields"
            }
    }
   
    
//    func sharePost(completed: @escaping() -> Void,  onError: @escaping(_ errorMessage: String) -> Void) {
//          if !caption.isEmpty && !imageData.isEmpty {
//             //AuthService.signupUser(username: username, email: email, password: password, imageData: imageData, onSuccess: completed, onError: onError)
//            Api.Post.uploadPost(caption: caption, imageData: imageData, onSuccess: completed, onError: onError)
//
//          } else {
//              showAlert = true
//              errorString = "Please fill in all fields"
//          }
//
//    }
}

