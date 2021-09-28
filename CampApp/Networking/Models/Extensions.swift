//
//  Extensions.swift
//  CampApp
//
//  Created by yusuf terzi on 23.09.2021.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

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
}
