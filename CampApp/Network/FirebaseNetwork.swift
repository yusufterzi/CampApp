//
//  FirebaseNetwork.swift
//  CampApp
//
//  Created by yusuf terzi on 23.09.2021.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import YTNetwork

public final class FirebaseNetwork {
  public static var shared: FirebaseNetwork?
  internal var database: FirebaseFirestore.Firestore
  
  public init(_ database: FirebaseFirestore.Firestore) {
    self.database = database
    FirebaseNetwork.shared = self
  }
  
  public func allCampAreas(completion: @escaping (GenericResult<[CampModel]>) -> Void) {
    let ref = database.collection("camp")
    let query = ref.limit(to: 50)
    query.getDocumentsObjects { (result: GenericResult<[CampModel]>) in
      completion(result)
    }
  }
  
}


