//
//  ChatApi.swift
//  Social
//
//  Created by User on 22/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import Firebase

class ChatApi {
    func sendMessages(message: String, recipientId: String, recipientAvatarUrl: String, recipientUsername: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        guard let senderId = Auth.auth().currentUser?.uid else { return }
        guard let senderUsername = Auth.auth().currentUser?.displayName else { return }
        guard let senderAvatarUrl = Auth.auth().currentUser?.photoURL!.absoluteString else { return }
        
        let messageId = Ref.FIRESTORE_COLLECTION_CHATROOM(senderId: senderId, recipientId: recipientId).document().documentID
        let chat = Chat(messageId: messageId, textMessage: message, avatarUrl: senderAvatarUrl, photoUrl: "", senderId: senderId, username: senderUsername, date: Date().timeIntervalSince1970, type: "TEXT")
        
        guard let dict = try? chat.toDictionary() else { return }
        
        Ref.FIRESTORE_COLLECTION_CHATROOM(senderId: senderId, recipientId: recipientId).document(messageId).setData(dict) { (error) in
            if error  == nil {
                Ref.FIRESTORE_COLLECTION_CHATROOM(senderId: recipientId, recipientId: senderId).document(messageId).setData(dict)
                
                let inboxmessage1 = InboxMessage(lastMessage: message, username: recipientUsername, type: "TEXT", date: Date().timeIntervalSince1970, userId: recipientId, avatarUrl: recipientAvatarUrl)
                let inboxmessage2 = InboxMessage(lastMessage: message, username: senderUsername, type: "TEXT", date: Date().timeIntervalSince1970, userId: senderId, avatarUrl: senderAvatarUrl)
                
                guard let inboxDict1 = try? inboxmessage1.toDictionary() else { return }
                guard let inboxDict2 = try? inboxmessage2.toDictionary() else { return }
                
                Ref.FIRESTORE_COLLECTION_INBOX_MESSAGES_DOCUMENT_USERID(senderId: senderId, recipientId: recipientId).setData(inboxDict1)
                Ref.FIRESTORE_COLLECTION_INBOX_MESSAGES_DOCUMENT_USERID(senderId: recipientId, recipientId: senderId).setData(inboxDict2)
                onSuccess()
            } else {
                onError(error!.localizedDescription)
            }
        }
    }
    
    func sendPhotoMessages(recipientId: String, recipientAvatarUrl: String, recipientUsername: String, imageData: Data, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        guard let senderId = Auth.auth().currentUser?.uid else { return }
        guard let senderUsername = Auth.auth().currentUser?.displayName else { return }
        guard let senderAvatarUrl = Auth.auth().currentUser?.photoURL!.absoluteString else { return }
        
        let messageId = Ref.FIRESTORE_COLLECTION_CHATROOM(senderId: senderId, recipientId: recipientId).document().documentID
        
        let storageChatRef = Ref.STORAGE_CHAT_ID(chatId: messageId)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        StorageService.saveChatPhoto(messageId: messageId, senderId: senderId, senderUsername: senderUsername, senderAvatarUrl: senderAvatarUrl, recipientId: recipientId, recipientAvatarUrl: recipientAvatarUrl, recipientUsername: recipientUsername, imageData: imageData, metadata: metadata, storageChatRef: storageChatRef, onSuccess: onSuccess, onError: onError)
    }
    
    func getChatMessages(withUser userId: String, onSuccess: @escaping([Chat]) -> Void, onError: @escaping(_ errorMessage: String) -> Void, newChatMessage: @escaping(Chat) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        let listenerFirestore = Ref.FIRESTORE_COLLECTION_CHATROOM(senderId: Auth.auth().currentUser!.uid, recipientId: userId).order(by: "date", descending: false).addSnapshotListener { (querySnapshot, error) in
                guard let snapshot = querySnapshot else {
                    return
                }
                
                var chatArray = [Chat]()
    //            for document in snapshot.documents {
    //                let dict = document.data()
    //                guard let decoderComment = try? Comment.init(fromDictionary: dict) else {return}
    //                comments.append(decoderComment)
    //                print("comment data")
    //                print(decoderComment.comment)
    //            }
                
                snapshot.documentChanges.forEach { (documentChange) in
                    switch documentChange.type {
                    case .added:
                        print("type: added")
                        let dict = documentChange.document.data()
                        guard let decoderChat = try? Chat.init(fromDictionary: dict) else {return}
                        newChatMessage(decoderChat)
                        chatArray.append(decoderChat)
                        
                    case .modified:
                        print("type: modifier")
                    case .removed:
                        print("type: removed")
                    }
                }
                
                onSuccess(chatArray)
            }
            
            listener(listenerFirestore)
        }
    
    func getInboxMessages(onSuccess: @escaping([InboxMessage]) -> Void, onError: @escaping(_ errorMessage: String) -> Void, newInboxMessage: @escaping(InboxMessage) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        let listenerFirestore = Ref.FIRESTORE_COLLECTION_INBOX_MESSAGES(userId: Auth.auth().currentUser!.uid).order(by: "date", descending: true).addSnapshotListener { (querySnapshot, error) in
                guard let snapshot = querySnapshot else {
                    return
                }
                
                var inboxMessage = [InboxMessage]()
    //            for document in snapshot.documents {
    //                let dict = document.data()
    //                guard let decoderComment = try? Comment.init(fromDictionary: dict) else {return}
    //                comments.append(decoderComment)
    //                print("comment data")
    //                print(decoderComment.comment)
    //            }
                
                snapshot.documentChanges.forEach { (documentChange) in
                    switch documentChange.type {
                    case .added:
                        print("type: added")
                        let dict = documentChange.document.data()
                        guard let decoderInboxMessage = try? InboxMessage.init(fromDictionary: dict) else {return}
                        newInboxMessage(decoderInboxMessage)
                        inboxMessage.append(decoderInboxMessage)
                        
                    case .modified:
                        print("type: modifier")
                    case .removed:
                        print("type: removed")
                    }
                }
                
                onSuccess(inboxMessage)
            }
            
            listener(listenerFirestore)
        }
}
