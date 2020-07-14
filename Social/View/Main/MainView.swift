//
//  MainView.swift
//  Social
//
//  Created by User on 17/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var session: SessionStore
    func logout() {
        session.logout()
    }
    var body: some View {
        TabView {
            HomeView().tabItem({
                Image(systemName: "gift.fill")
                }).tag(0)
            SearchView().tabItem({
                Image(systemName: "magnifyingglass")
            }).tag(1)
            CameraView().tabItem({
                Image(systemName: "camera")
            }).tag(2)
            NotificationView().tabItem({
                Image(systemName: "bell")
            }).tag(3)
            ProfileView().tabItem({
                Image(systemName: "person")
            }).tag(4)
            
        }.accentColor(.black)
        
//        Group {
//            Text((session.userSession == nil) ? "Loading..." : session.userSession!.email)
//            Button(action: logout) {
//                Text("Log out")
//            }
//        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
