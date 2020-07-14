//
//  SearchView.swift
//  Social
//
//  Created by User on 18/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import SwiftUI

struct Photo: Identifiable {
    let id = UUID()
    var photo = ""
}

struct SearchView: View {
    
    @ObservedObject var postPopularViewModel = PostPopularViewModel()
    @State var selection = Selection.grid
   
    var body: some View {
        return
               NavigationView {
                   ScrollView {
                   
                   Picker(selection: $selection, label: Text("Grid or Table")) {
                         ForEach(Selection.allCases) { selection in
                             selection.image.tag(selection)
                                                         }
                       }.pickerStyle(SegmentedPickerStyle()).padding()
                      if !postPopularViewModel.isLoading {
                          if selection == .grid {
                            GridPosts(splitted: self.postPopularViewModel.splitted)
                          } else {
                              ForEach(self.postPopularViewModel.posts, id: \.postId) { post in
                                  VStack {
                                      HeaderCell(post: post)
                                      FooterCell(post: post)
                                  }
                                  
                              }
                             
                          }
                          
                      }
                   }.navigationBarTitle(Text("Most Liked Presents"), displayMode: .inline).onAppear {
                               self.postPopularViewModel.loadPostPopular()
                   }
               }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
