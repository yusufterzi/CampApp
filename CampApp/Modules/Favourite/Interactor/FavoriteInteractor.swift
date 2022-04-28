//
//  FavoriteInteractor.swift
//  CampApp
//
//  Created by Nurullah Vural on 28.04.2022.
//


import Foundation
import YTUI
import YTNetwork
import Common

protocol FavoriteInteractorProtocol: BaseInteractor {
  
  func loadData()
  var camps: [CampModel] { get set }
  var loadHandler: VoidHandler? { get set }
  var emptyHandler: VoidHandler? { get set }

}

final class FavoriteInteractor: FavoriteInteractorProtocol {
  
  func getItems() { }
  
  var loadHandler: VoidHandler?
  var emptyHandler: VoidHandler?

  var camps: [CampModel] = .init()
  
  
  func loadData() {
    getFavouriteCamps()
  }
  
  private func getFavouriteCamps() {
    FirebaseNetwork.shared?.getFavouriteCamps { [weak self] response in
      if let data = response.value {
        if data.count > 0 {
          self?.camps = data
          self?.loadHandler?()
          return
        }
        self?.emptyHandler?()
      }
    }
  }
  
}
