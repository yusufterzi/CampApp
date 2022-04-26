//
//  FirebaseNetwork+User.swift
//  CampApp
//
//  Created by yusuf terzi on 26/04/2022.
//

import Foundation
import YTNetwork
import FirebaseAuth

extension FirebaseNetwork {
  func setFavourite(campId: String,
                    completion: @escaping (GenericResult<Void>) -> Void) {
    guard let user = SessionHelper.shared.user else { return }
    let document = database.collection("user").document("\(user.userID)")
    
    var favouriteAreas: [String] = user.favouriteAreas
    favouriteAreas.append(campId)
    user.favouriteAreas = favouriteAreas
    
    var parameter = Parameters()
    parameter[CampUser.Keys.favouriteAreas] = favouriteAreas

    document.setData(parameter, merge: true) { error in
      if let error = error {
        completion(.failure(error))
        return
      }
      completion(.success)
    }
  }
  
  func getUser() {
    guard let currentUser = Auth.auth().currentUser else {
      return
    }
    
    let ref = database.collection("user").document("\(currentUser.uid)")
    ref.getDocument { snapshot, error in
      if error != nil {
        guard let data = snapshot?.data(),
              let documentID = snapshot?.documentID else {
          return
        }
        
        let user = CampUser(userID: documentID, snapshotValue: data)
        SessionHelper.shared.user = user
      }
    }
  }
}
