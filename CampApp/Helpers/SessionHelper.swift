//
//  SessionHelper.swift
//  CampApp
//
//  Created by yusuf terzi on 26/04/2022.
//

import Foundation
import FirebaseAuth

final class SessionHelper {
  static var shared: SessionHelper = SessionHelper()
  
  var userID: String?
  
  func loginAnymous() {
    if let userID = UserDefaults.standard.string(forKey: "userID"){
      self.userID = userID
    } else {
      Auth.auth().signInAnonymously() { [weak self] (user, error) in
        if let user = user, let self = self {
          self.userID = user.user.uid
          UserDefaults.standard.set(self.userID, forKey: "userID")
        }}
    }
  }
}
