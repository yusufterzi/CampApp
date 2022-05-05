//
//  WelcomeInteractor.swift
//  CampApp
//
//  Created by Nurullah Vural on 29.04.2022.
//

import Common
import YTUI
import YTNetwork


protocol WelcomeInteractorProtocol: BaseInteractor {
  func loadData()
  var loadHandler: VoidHandler? { get set }
  
}

final class WelcomeInteractor: WelcomeInteractorProtocol {
  var loadHandler: VoidHandler?
  
  func getItems() {
  }
  
  func loadData() {
  }
  
}
