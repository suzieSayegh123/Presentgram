//
//  ChatView.swift
//  Social
//
//  Created by User on 18/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import SwiftUI

struct ChatView: View {
    
    @ObservedObject var chatViewModel = ChatViewModel()
    
    var recipientId = ""
    var recipientAvatarUrl = ""
    var recipientUsername = ""

    func sendTextMessage() {
        
        
        chatViewModel.sendTextMessage(recipientId: recipientId, recipientAvatarUrl: recipientAvatarUrl, recipientUsername: recipientUsername, completed: {
            self.clean()
        }) { (errorMessage) in
            self.chatViewModel.showAlert = true
            self.chatViewModel.errorString = errorMessage
            self.clean()
        }
    }
    
    func sendPhoto() {
        chatViewModel.sendPhotoMessage(recipientId: recipientId, recipientAvatarUrl: recipientAvatarUrl, recipientUsername: recipientUsername, completed: {
            
        }) { (errorMessage) in
            self.chatViewModel.showAlert = true
            self.chatViewModel.errorString = errorMessage
        }
    }
    
    func showPicker() {
        self.chatViewModel.showImagePicker = true
    }
    
    func clean() {
        self.chatViewModel.composedMessages = ""
    }
    
    var body: some View {
            VStack {
               ScrollView {
                
                if !chatViewModel.chatArray.isEmpty {
                    ForEach(chatViewModel.chatArray, id: \.messageId) { chat in
                        VStack(alignment: .leading) {
                            if chat.isPhoto {
                                PhotoMessageRow(chat: chat)
                            } else {
                                TextMessageRow(chat: chat)
                            }
                        }.padding(.top, 20)
                   }
                }
               }
                HStack(spacing: 0) {
                    
                    ZStack {
                         RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 1).padding()
                        
                        HStack(spacing: 10) {
                            Button(action: {}) {
                                Image(systemName: "camera.fill").padding(12).foregroundColor(.white).background(Color.blue).clipShape(Circle())
                            }.padding(.leading, 20)
                            
                            TextField("Message...", text: $chatViewModel.composedMessages).padding(.top, 30).padding(.bottom, 30)
                             Button(action: showPicker) {
                                 Image(systemName: "photo").imageScale(.large).foregroundColor(.black)
                             }
                            Button(action: {}) {
                                                    Image(systemName: "mic.fill").imageScale(.large).foregroundColor(.black)
                                                     }
                            Button(action: sendTextMessage) {
                                Image(systemName: "text.bubble").imageScale(.large).foregroundColor(.black).padding(.trailing, 30)
                                                                                }
                         }

                     }.frame(height: 60)
                }
            }.sheet(isPresented: $chatViewModel.showImagePicker, onDismiss: {
                self.sendPhoto()
            }) {
               // ImagePickerController()
                ImagePicker(showImagePicker: self.$chatViewModel.showImagePicker, pickedImage: self.$chatViewModel.image, imageData: self.$chatViewModel.imageData)
            }.navigationBarTitle(Text("Chat"), displayMode: .inline).alert(isPresented: $chatViewModel.showAlert) {
                Alert(title: Text("Error"), message: Text(self.chatViewModel.errorString), dismissButton: .default(Text("OK")))
            }.onAppear {
                self.chatViewModel.repicientId = self.recipientId
                self.chatViewModel.loadChatMessages()
            }.onDisappear {
                if self.chatViewModel.listener != nil {
                    self.chatViewModel.listener.remove()
                }
            }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}

import URLImage

struct TextMessageRow: View {
    var chat:  Chat
    var body: some View {
        Group {
            if !chat.isCurrentUser {
                HStack(alignment: .top) {
                    URLImage(URL(string: chat.avatarUrl)!,
                    content: {
                        $0.image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                    }).frame(width: 30, height: 30).clipShape(Circle())
                    Text(chat.textMessage).padding(10).foregroundColor(.black).background(Color(red: 237/255, green: 237/255, blue: 237/255)).cornerRadius(10).font(.callout)
                    Spacer()
                }.padding(.leading, 15).padding(.trailing, 50)
                     } else {
                        HStack(alignment: .top) {
                             Spacer(minLength: 50)
                            Text(chat.textMessage).padding(10).foregroundColor(.white).background(Color.blue).cornerRadius(10).font(.callout)
                        }.padding(.trailing, 15)
                    }
                }
            }
        }
        
        struct PhotoMessageRow: View {
            var chat:  Chat
            var body: some View {
                Group {
                    if !chat.isCurrentUser {
                        HStack(alignment: .top) {
                             URLImage(URL(string: chat.avatarUrl)!,
                             content: {
                                 $0.image
                                     .resizable()
                                     .aspectRatio(contentMode: .fill)
                                     .clipShape(Circle())
                             }).frame(width: 30, height: 30).clipShape(Circle())
                                  URLImage(URL(string: chat.photoUrl)!,
                                  content: {
                                      $0.image
                                          .resizable()
                                          .aspectRatio(contentMode: .fill)
                                  }).frame(width: 200, height: 200).cornerRadius(10)
                             Spacer()
                        }.padding(.leading, 15)
                             } else {
                                HStack {
                                    Spacer()
                                    URLImage(URL(string: chat.photoUrl)!,
                                    content: {
                                        $0.image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                    }).frame(width: 200, height: 200).cornerRadius(10)
                               }.padding(.trailing, 15)
}
}
}
}
