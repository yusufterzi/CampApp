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
  var onboardingImages: [OnboardingImageModel] { get set }
  
}

final class WelcomeInteractor: WelcomeInteractorProtocol {
  var loadHandler: VoidHandler?
  var onboardingImages: [OnboardingImageModel] = .init()
  
  func getItems() {
  }
  
  func loadData() {
    getOnboardingImages()
  }
  func getOnboardingImages() {
    FirebaseNetwork.shared?.getOnboardingImages { [weak self] response in
      if let data = response.value {
        self?.onboardingImages = data
        self?.loadHandler?()
      }
    }
    
  }
  
}
