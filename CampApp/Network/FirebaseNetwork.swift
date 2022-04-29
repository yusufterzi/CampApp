//
//  FirebaseNetwork.swift
//  CampApp
//
//  Created by yusuf terzi on 23.09.2021.
//

import FirebaseFirestore
import Firebase
import FirebaseStorage
import YTNetwork
import Geofirestore
import MapKit

public final class FirebaseNetwork {
  public static var shared: FirebaseNetwork?
  var database: FirebaseFirestore.Firestore
  var storage: Storage
  
  let geoFirestore: GeoFirestore
  
  public init(_ database: FirebaseFirestore.Firestore) {
    self.database = database
    self.storage = Storage.storage()
    
    let geoFirestoreRef = database.collection("camp")
    geoFirestore = GeoFirestore(collectionRef: geoFirestoreRef)
    
    FirebaseNetwork.shared = self

  }
  
  public func allCamps(completion: @escaping (GenericResult<[CampModel]>) -> Void) {
    let ref = database.collection("camp")
    let query = ref.limit(to: 50)
    query.getDocumentsObjects { (result: GenericResult<[CampModel]>) in
      completion(result)
    }
  }
  
  public func nearestCamps() {
    let center = CLLocation(latitude: 37.7832889, longitude: -122.4056973)
    let circleQuery = geoFirestore.query(withCenter: center, radius: 0.6)
    _ = circleQuery.observeReady {
      // alayı tamam return data remove observer
    }
    _ = circleQuery.observe(.documentEntered, with: { [weak self] (key, location) in
      guard let self = self, let key = key else { return }
      self.database.collection("camp").document(key).getDocument { (document, error) in
        if let document = document, document.exists {
          
        } else {
          print("Document does not exist.")
        }
      }
    })
  }
  
  public func allCampAreas(completion: @escaping (GenericResult<[CampAreaModel]>) -> Void) {
    let ref = database.collection("areas")
    let query = ref.limit(to: 50)
    query.getDocumentsObjects { (result: GenericResult<[CampAreaModel]>) in
      completion(result)
    }
  }
  
  public func addCamp(data: CampModel?, completion: @escaping (GenericResult<Bool>) -> Void) {
    let ref = database.collection("camp").document()
    data?.id = ref.documentID
    
    guard let parameters = data?.getParameters() else { return }
    ref.setData(parameters) { err in
      if let err = err {
        debugPrint("Error adding document: \(err)")
        completion(.failure(err))
      } else {
        completion(.success(true))
      }
      
    }
  }
  
  public func uploadCampImage(images: [CampImageModel]?, completion: @escaping (GenericResult<Bool>) -> Void) {
    guard let images = images else {
      return
    }
    images.enumerated().forEach { (index, image) in
      guard let  imageData = image.campImage.jpegData(compressionQuality: 0.75) else {
        return
      }
      let ref = self.storage.reference().child("images/\(image.uuid).jpg")
      ref.putData(imageData, metadata: nil) { (metadata , error) in
        if let err = error {
          debugPrint (err.localizedDescription)
          return
        }
        ref.downloadURL{ (url, error) in
          if let err = error {
            debugPrint (err.localizedDescription)
            return
          }
          guard let url = url else {
            return
          }
          
          debugPrint("URL: \(url.absoluteString)")
        }
        
      }
    }
    
    completion(.success(true))
  }
  
}


