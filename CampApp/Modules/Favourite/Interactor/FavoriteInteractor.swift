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
}

final class FavoriteInteractor: FavoriteInteractorProtocol {
  
  func getItems() { }
  
  var loadHandler: VoidHandler?
  var camps: [CampModel] = .init()
  
  
  func loadData() {
    getFavouriteCamps()
  }
  
  private func getFavouriteCamps() {
    FirebaseNetwork.shared?.getFavouriteCamps { [weak self] response in
      if let data = response.value {
        self?.camps = data
        self?.loadHandler?()
      }
    }
  }
  
}
