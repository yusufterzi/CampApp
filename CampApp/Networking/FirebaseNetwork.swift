//
//  FirebaseNetwork.swift
//  CampApp
//
//  Created by yusuf terzi on 23.09.2021.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

final class FirebaseNetwork {
  var shared: FirebaseNetwork = FirebaseNetwork()
  var database = Firestore.firestore()
  func allCampAreas(completion: @escaping (GenericResult<[CampModel]>) -> Void) {
    let ref = database.collection("camps")
    let query = ref.limit(to: 50)
    query.getDocumentsObjects { (result: GenericResult<[CampModel]>) in
      completion(result)
    }
  }
  
}


