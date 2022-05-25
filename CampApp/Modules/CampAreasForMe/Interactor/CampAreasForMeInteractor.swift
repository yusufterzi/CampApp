//
//  CampAreasForMeInteractor.swift
//  CampApp
//
//  Created by yusuf terzi on 27/04/2022.
//

import Foundation
import YTUI
import YTNetwork
import Common

protocol CampAreasForMeInteractorProtocol: BaseInteractor {
  var camps: [CampModel] { get set }
  var loadHandler: VoidHandler? { get set }
}

final class CampAreasForMeInteractor: CampAreasForMeInteractorProtocol {
  
  var loadHandler: VoidHandler?
  var camps: [CampModel] = .init()
  
  func getItems() {
    getCamps()
  }

  private func getCamps() {
    FirebaseNetwork.shared?.allCamps(campSegment: HomeSegmentEnum.all) { [weak self] response in
      if let data = response.value {
        self?.camps = data
        self?.loadHandler?()
      }
    }
  }
  
}
