//
//  CampDetailInteractor.swift
//  CampApp
//
//  Created by yusuf terzi on 4.10.2021.
//

import Common
import YTUI

protocol CampDetailInteractorProtocol: BaseInteractor {
  
    var loadHandler: VoidHandler? { get set }
}

final class CampDetailInteractor: CampDetailInteractorProtocol {

  var loadHandler: VoidHandler?
  
  func getItems() {
    
  }
  
}
