//
//  HomeInteractor.swift
//  CampApp
//
//  Created by yusuf terzi on 28.09.2021.
//

import Foundation
import YTUI
import YTNetwork

protocol HomeInteractorProtocol: BaseInteractor {
  
  func getCampAreas()
  
  var campAreasHandler: (([CampModel]) -> Void)? { get set }
}

final class HomeInteractor: HomeInteractorProtocol {
  func getItems() { }
  
  var campAreasHandler: (([CampModel]) -> Void)?

  func getCampAreas() {
    FirebaseNetwork.shared?.allCampAreas { [weak self] response in
      if let data = response.value {
        self?.campAreasHandler?(data)
      }
    }
  }
  
}
