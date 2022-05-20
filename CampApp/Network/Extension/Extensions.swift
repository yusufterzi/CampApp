//
//  Extensions.swift
//  CampApp
//
//  Created by yusuf terzi on 23.09.2021.
//

import FirebaseFirestore
import YTNetwork

public typealias Parameters = [String: Any]

extension Parameters {
  func decoded<T: Decodable>() -> T? {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: self)
      return try jsonData.decoded() as T
    } catch {
      return nil
    }
  }
  
  func decodeCampModel() -> CampModel? {
    
      let item = CampModel(name: "", subLocation: "", city: "", description: "", images: [], latitude: 0, longitude: 0, point: 0, address: "")
      item.id = (self["id"] as? String) ?? UUID().uuidString
      item.address = (self["address"] as? String)
      item.name = (self["name"] as? String)
      item.subLocation = (self["subLocation"] as? String)
      item.city = (self["city"] as? String)
      item.description = (self["description"] as? String)
      item.images = (self["images"] as? [String])
      item.latitude = (self["latitude"] as? Double)
      item.longitude = (self["longitude"] as? Double)
      item.point = (self["point"] as? Double)
      item.area = (self["area"] as? [Int])
      item.type = (self["type"] as? [Int])
      item.createdOn = (self["createdOn"] as? Timestamp)?.dateValue()
      item.updatedOn = (self["updatedOn"] as? Timestamp)?.dateValue()

      return item
    
  }
}


extension Encodable {
  func encoded() throws -> Data {
    return try JSONEncoder().encode(self)
  }
}

extension Data {
  func decoded<T: Decodable>() throws -> T {
    return try JSONDecoder().decode(T.self, from: self)
  }
}

extension Query {
  func getDocumentsObjects<T: Decodable>(completion: @escaping (GenericResult<[T]>) -> Void) {
    var responseArray: [T] = .init()
    self.getDocuments { snapshot, error in
      if let error = error {
        completion(.failure(error))
      } else {
        guard let snapshot = snapshot else {
          completion(.failure(CampError.snapshotFailed))
          return
        }
        
        for document in snapshot.documents {
          if let item = document.data().decoded() as T? {
            responseArray.append(item)
          }
        }
        completion(.success(responseArray))
      }
    }
  }
  
  func getCampModelObjects (completion: @escaping (GenericResult<[CampModel]>) -> Void) {
    var responseArray: [CampModel] = .init()
    self.getDocuments { snapshot, error in
      if let error = error {
        completion(.failure(error))
      } else {
        guard let snapshot = snapshot else {
          completion(.failure(CampError.snapshotFailed))
          return
        }
        
        for document in snapshot.documents {
          if let item = document.data().decodeCampModel() as CampModel? {
            responseArray.append(item)
          }
        }
        completion(.success(responseArray))
      }
    }
  }

}
