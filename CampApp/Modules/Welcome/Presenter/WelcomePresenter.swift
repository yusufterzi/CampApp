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
  var completionHandler: VoidHandler? { get set }

}

final class WelcomePresenter: WelcomePresenterProtocol {
  
  internal var router: UnownedRouter<MainRoute>
  internal var interactor: WelcomeInteractorProtocol?
  public var onboardingImages: [OnboardingImageModel] = []
  public var completionHandler: VoidHandler?
  
  init(router: UnownedRouter<MainRoute>) {
    self.router = router
    self.interactor = WelcomeInteractor()
  }
  
  public func loadUI() {
    interactor?.loadData()
    interactor?.loadHandler = { [weak self] in
      if (self?.interactor?.onboardingImages.count ?? 0) > 0 {
        self?.dataLoaded()
      }
    }
    
  }
  func dataLoaded() {
    guard let interactor = interactor else { return }
    onboardingImages = interactor.onboardingImages
    self.completionHandler?()
  }
  
}




