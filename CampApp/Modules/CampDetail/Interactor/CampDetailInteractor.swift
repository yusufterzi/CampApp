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
    func setFavorite(campId: String, completion: @escaping (GenericResult<Void>) -> Void)

}

final class CampDetailInteractor: CampDetailInteractorProtocol {

  var loadHandler: VoidHandler?
  
  func getItems() {
    
  }
  
  func setFavorite(campId: String, completion: @escaping (GenericResult<Void>) -> Void) {
    FirebaseNetwork.shared?.setFavourite(campId: campId, completion: completion)
  }
  
}
