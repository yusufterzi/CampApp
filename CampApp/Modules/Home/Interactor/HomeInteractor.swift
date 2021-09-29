//
//  HomeInteractor.swift
//  CampApp
//
//  Created by yusuf terzi on 28.09.2021.
//

import Foundation
import YTUI
import YTNetwork

final class HomeInteractor: BaseInteractor {
  
  func getCampAreas(completion: @escaping ([CampModel]) -> ()) {
    FirebaseNetwork.shared?.allCampAreas { response in
      if let data = response.value {
        completion(data)
      }
    }
  }
  
}
