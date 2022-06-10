//
//  Extensions.swift
//  CampApp
//
//  Created by yusuf terzi on 23.09.2021.
//

import FirebaseFirestore
import YTNetwork

public enum FirebaseConstant {
  static let id: String = "id"
  static let areas: String = "areas"
  static let camp: String = "camp"
  static let type: String = "type"
  static let updatedOn: String = "updatedOn"
  static let createdOn: String = "createdOn"
  static let address: String = "address"
  static let name: String = "name"
  static let subLocation: String = "subLocation"
  static let city: String = "city"
  static let description: String = "description"
  static let images: String = "images"
  static let latitude: String = "latitude"
  static let longitude: String = "longitude"
  static let point: String = "point"
  static let area: String = "area"
  static let introImageIndex: String = "introImageIndex"
  static let user: String = "user"

}

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
      item.id = (self[FirebaseConstant.id] as? String) ?? UUID().uuidString
      item.address = (self[FirebaseConstant.address] as? String)
      item.name = (self[FirebaseConstant.name] as? String)
      item.subLocation = (self[FirebaseConstant.subLocation] as? String)
      item.city = (self[FirebaseConstant.city] as? String)
      item.description = (self[FirebaseConstant.description] as? String)
      item.images = (self[FirebaseConstant.images] as? [String])
      item.latitude = (self[FirebaseConstant.latitude] as? Double)
      item.longitude = (self[FirebaseConstant.longitude] as? Double)
      item.point = (self[FirebaseConstant.point] as? Double)
      item.area = (self[FirebaseConstant.area] as? [Int])
      item.type = (self[FirebaseConstant.type] as? [Int])
      item.createdOn = (self[FirebaseConstant.createdOn] as? Timestamp)?.dateValue()
      item.updatedOn = (self[FirebaseConstant.updatedOn] as? Timestamp)?.dateValue()
      item.introImageIndex = (self[FirebaseConstant.introImageIndex] as? Int)


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
