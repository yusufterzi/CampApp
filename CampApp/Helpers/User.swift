//
//  User.swift
//  CampApp
//
//  Created by yusuf terzi on 26/04/2022.
//

import FirebaseFirestore

final class CampUser {
  
  enum Keys {
    static let favouriteCamps: String = "favouriteCamps"
  }
  
  let userID: String
  var favouriteCamps: [String]
  
  init(userID: String, snapshotValue: [String: Any]) {
    self.userID = userID
    self.favouriteCamps = (snapshotValue[Keys.favouriteCamps] as? [String]) ?? []

  }
  
}
