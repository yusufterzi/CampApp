//
//  CampDetailInteractor.swift
//  CampApp
//
//  Created by yusuf terzi on 4.10.2021.
//

import Common
import YTUI
import YTNetwork


protocol CampDetailInteractorProtocol: BaseInteractor {
  var loadHandler: VoidHandler? { get set }
  func addFavorite(campId: String, completion: ((GenericResult<Void>) -> Void)?)
  func deleteFavorite(campId: String, completion: ((GenericResult<Void>) -> Void)?)
}

final class CampDetailInteractor: CampDetailInteractorProtocol {
  
  var loadHandler: VoidHandler?
  
  func getItems() {
    
  }
  
  func addFavorite(campId: String, completion: ((GenericResult<Void>) -> Void)?) {
    FirebaseNetwork.shared?.addFavourite(campId: campId, completion: completion)
  }
  
  func deleteFavorite(campId: String, completion: ((GenericResult<Void>) -> Void)?) {
    FirebaseNetwork.shared?.deleteFavorite(campId: campId, completion: completion)
  }
  
}
