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
  func addFavourite(campId: String,
                    completion: ((GenericResult<Void>) -> Void)?) {
    guard let user = SessionHelper.shared.user else { return }
    let document = database.collection("user").document("\(user.userID)")
    
    var favouriteCamps: [String] = user.favouriteCamps
    favouriteCamps.append(campId)
    user.favouriteCamps = favouriteCamps
    
    var parameter = Parameters()
    parameter[CampUser.Keys.favouriteCamps] = favouriteCamps

    document.setData(parameter, merge: true) { error in
      if let error = error {
        completion?(.failure(error))
        return
      }
      completion?(.success)
    }
  }
  
  func deleteFavorite(campId: String,
                      completion: ((GenericResult<Void>) -> Void)?) {
    guard let user = SessionHelper.shared.user else { return }
    let document = database.collection("user").document("\(user.userID)")
    
    var favouriteCamps: [String] = user.favouriteCamps
    favouriteCamps.removeAll(where: { campId == $0 } )
    user.favouriteCamps = favouriteCamps
    
    var parameter = Parameters()
    parameter[CampUser.Keys.favouriteCamps] = favouriteCamps

    document.setData(parameter, merge: true) { error in
      if let error = error {
        completion?(.failure(error))
        return
      }
      completion?(.success)
    }
  }
  
  func getUser() {
    guard let currentUser = Auth.auth().currentUser else {
      return
    }
    
    let ref = database.collection("user").document("\(currentUser.uid)")
    ref.getDocument { snapshot, error in
      guard let data = snapshot?.data(),
            let documentID = snapshot?.documentID else {
        SessionHelper.shared.user = CampUser(userID: currentUser.uid, snapshotValue: Parameters())
        return
      }
      
      let user = CampUser(userID: documentID, snapshotValue: data)
      SessionHelper.shared.user = user
    }
  }
  
}
