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
  
  var user: CampUser?

  func loginAnymous() {
    if Auth.auth().currentUser != nil {
      getUser()
      return
    }

    Auth.auth().signInAnonymously() { [weak self] (_, _) in
      self?.getUser()
    }
  }
  
  func getUser() {
    FirebaseNetwork.shared?.getUser()
  }
}
