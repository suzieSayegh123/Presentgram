//
//  InitialView.swift
//  Social
//
//  Created by User on 17/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import SwiftUI

struct InitialView: View {
    
    @EnvironmentObject var session: SessionStore
    
    func listen() {
        session.listenAuthenticationState()
    }
    
    var body: some View {
        Group {
            if session.isLoggedIn {
                MainView()
            } else {
                //to change to welcome
                SigninView()
            }
            
        }.onAppear(perform: listen)
    }
}



struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    
    }
}
