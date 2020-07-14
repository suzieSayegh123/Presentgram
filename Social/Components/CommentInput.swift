//
//  CommentInput.swift
//  Social
//
//  Created by User on 18/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import SwiftUI
import URLImage
struct CommentInput: View {
    @EnvironmentObject var session: SessionStore
    @ObservedObject var commentInputViewModel = CommentInputViewModel()
    
    @State var composedMessage: String = ""
    
    init(post: Post?, postId: String?) {
        if post != nil {
            commentInputViewModel.post = post
        } else {
            handleInputViewModel(postId: postId!)
        }
    }
    
    func handleInputViewModel(postId: String) {
        Api.Post.loadPost(postId: postId) { (post) in
            self.commentInputViewModel.post = post
        }
    }
    
    func commentAction() {
        if !composedMessage.isEmpty {
            commentInputViewModel.addComments(text: composedMessage) {
                self.composedMessage = ""
            }
        }
    }
    
    var body: some View {
        HStack(spacing: 0) {
            URLImage(URL(string: session.userSession!.profileImageUrl)!,
                                                    content: {
                                                        $0.image
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .clipShape(Circle())
                                                    }).frame(width: 50, height: 50
            ).padding(.leading, 15)
            ZStack {
                 RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 1).padding()
                 HStack {
                     TextField("Add a comment", text: $composedMessage).padding(30)
                     Button(action: commentAction) {
                         Image(systemName: "paperplane").imageScale(.large).foregroundColor(.black).padding(30)
                     }
                 }

             }.frame(height: 70)
        }
 
     
    }
}

//struct CommentInput_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentInput()
//    }
//}
