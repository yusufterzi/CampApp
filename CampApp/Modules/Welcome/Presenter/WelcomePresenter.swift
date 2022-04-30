//
//  WelcomePresenter.swift
//  CampApp
//
//  Created by Nurullah Vural on 14.02.2022.
//


import XCoordinator
import Carbon
import Common
import YTUI
import YTNetwork
import AttributedStringBuilder
import UIKit

protocol WelcomePresenterProtocol {

}

final class WelcomePresenter: WelcomePresenterProtocol {
  
  public var images: [WelcomeData] = [
      WelcomeData(name : "Ege", image: ImageProvider.onboardingEge),
      WelcomeData(name : "Karadeniz", image: ImageProvider.onboardingKaradeniz),
      WelcomeData(name : "Akdeniz", image: ImageProvider.onboardingAkdeniz),
      WelcomeData(name : "Marmara", image: ImageProvider.onboardingMarmara),
      WelcomeData(name : "İç Anadolu", image: ImageProvider.onboardingIcAnadolu),
      WelcomeData(name : "Doğu Anadolu", image: ImageProvider.onboardingDoguAnadolu)
  ]
  internal var router: UnownedRouter<MainRoute>
  internal var interactor: WelcomeInteractorProtocol?
  
  init(router: UnownedRouter<MainRoute>) {
    self.router = router
    self.interactor = WelcomeInteractor()
  }
  
  public func loadUI() {
   
  }

}




