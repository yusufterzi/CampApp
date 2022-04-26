//
//  User.swift
//  CampApp
//
//  Created by yusuf terzi on 26/04/2022.
//

import FirebaseFirestore

final class CampUser {
  
  enum Keys {
    static let favouriteAreas: String = "favouriteAreas"
  }
  
  let userID: String
  var favouriteAreas: [String]
  
  init(userID: String, snapshotValue: [String: Any]) {
    self.userID = userID
    self.favouriteAreas = (snapshotValue[Keys.favouriteAreas] as? [String]) ?? []

  }
  
}
