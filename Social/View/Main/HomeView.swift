//
//  HomeView.swift
//  Social
//
//  Created by User on 17/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//


import SwiftUI

struct HomeView: View {
    
    @ObservedObject var homeViewModel = HomeViewModel()
     
    var body: some View {
        NavigationView {
           ScrollView {
               Story()
                if !homeViewModel.isLoading {
                    ForEach(self.homeViewModel.posts, id: \.postId) { post in
                          VStack {
                              HeaderCell(post: post)
                              FooterCell(post: post)
                          }
                      }
                }
              
           }.navigationBarTitle(Text("Presentgram"), displayMode: .inline).onAppear {
                 self.homeViewModel.loadTimeline()
            }.navigationBarItems(trailing:
            Button(action: {}) {
                          NavigationLink(destination: MessagesView()) {
                              Image(systemName: "paperplane.fill").imageScale(Image.Scale.large).foregroundColor(.black)
                          }
                      }
            )
           .onDisappear {
                if self.homeViewModel.listener != nil {
                    self.homeViewModel.listener.remove()

                }
             }
           
       }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}







