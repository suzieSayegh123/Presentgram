//
//  ActivityViewModel.swift
//  Social
//
//  Created by User on 24/06/2020.
//  Copyright © 2020 Suzie Sayegh. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase

class ActivityViewModel: ObservableObject {
    @Published var activityArray: [Activity] = []
    var listener: ListenerRegistration!
    
    func loadActivities() {
        self.activityArray = []
        
        Api.Activity.loadActivities(onSuccess: { (activityArray) in
            if self.activityArray.isEmpty {
                self.activityArray = activityArray
            }
        }, newActivity: { (activity) in
             if !self.activityArray.isEmpty {
                self.activityArray.insert(activity, at: 0)
             }
        }, deleteActivity: { (activity) in
             if !self.activityArray.isEmpty {
                for(index, a) in self.activityArray.enumerated() {
                    if a.activityId == activity.activityId {
                        self.activityArray.remove(at: index)
                    }
                }
             }
        }) { (listener) in
            self.listener = listener
        }
    }
    
}

