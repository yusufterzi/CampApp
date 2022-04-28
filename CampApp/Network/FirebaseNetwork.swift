//
//  FirebaseNetwork.swift
//  CampApp
//
//  Created by yusuf terzi on 23.09.2021.
//

import FirebaseFirestore
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage
import YTNetwork

public final class FirebaseNetwork {
    public static var shared: FirebaseNetwork?
    internal var database: FirebaseFirestore.Firestore
    internal var storage: Storage
    
    public init(_ database: FirebaseFirestore.Firestore) {
        self.database = database
        self.storage = Storage.storage()
        FirebaseNetwork.shared = self
    }
    
    public func allCamps(completion: @escaping (GenericResult<[CampModel]>) -> Void) {
        let ref = database.collection("camp")
        let query = ref.limit(to: 50)
        query.getDocumentsObjects { (result: GenericResult<[CampModel]>) in
            completion(result)
        }
    }
    
    public func allCampAreas(completion: @escaping (GenericResult<[CampAreaModel]>) -> Void) {
        let ref = database.collection("areas")
        let query = ref.limit(to: 50)
        query.getDocumentsObjects { (result: GenericResult<[CampAreaModel]>) in
            completion(result)
        }
    }
    public func getFavouriteCamps(completion: @escaping (GenericResult<[CampModel]>) -> Void) {
      guard let user = SessionHelper.shared.user, user.favouriteCamps.count > 0 else {
        completion(.success([]))
        return
      }
      let ref = database.collection("camp").whereField("id", in: user.favouriteCamps)
      ref.getDocumentsObjects { (result: GenericResult<[CampModel]>) in
            completion(result)
      }
    }
  
    public func addCamp(data: CampModel?, completion: @escaping (GenericResult<Bool>) -> Void) {
        let ref = database.collection("camp").document()
        data?.id = ref.documentID
        do {
            try ref.setData(from: data) { err in
                if let err = err {
                    debugPrint("Error adding document: \(err)")
                    completion(.failure(err))
                } else {
                    completion(.success(true))
                }
                
            }
            
        } catch let error {
            debugPrint("Error writing to Firestore: \(error)")
            completion(.failure(error))
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


