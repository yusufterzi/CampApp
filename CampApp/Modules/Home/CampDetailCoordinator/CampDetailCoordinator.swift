//
//  CampDetailCoordinator.swift
//  CampApp
//
//  Created by yusuf terzi on 29/04/2022.
//

import XCoordinator
import YTNetwork
import YTUI
import FirebaseUI

enum CampDetailRoute: Route {
  case initialize(CampComponentViewModel)
  case imageSlider ([StorageReference])
  case back
  case dismiss
}

class CampDetailCoordinator: NavigationCoordinator<CampDetailRoute> {
  
  init(camp: CampComponentViewModel, root: RootViewController) {
    super.init(rootViewController: root)
    self.trigger(.initialize(camp))
  }
  
  override func prepareTransition(for route: CampDetailRoute) -> NavigationTransition {
    switch route {
    case .initialize(let camp):
      return showCampDetailController(item: camp)
    case .imageSlider(let images):
      return showImageSlider(images: images)
    case .back:
      return .pop()
    case .dismiss:
      return .dismiss()
    }
  }

  private func showCampDetailController(item: CampComponentViewModel) -> NavigationTransition {
    let viewController = CampDetailController()
    viewController.setupPresenter(presenter: CampDetailPresenter(view: viewController,
                                                                 router: self.unownedRouter,
                                                                 item: item))
    return .push(viewController, animation: .default)
    
  }
  private func showImageSlider(images: [StorageReference]) -> NavigationTransition {
    let viewController = ImageSliderController.instantiate()
    viewController.setupPresenter(presenter: ImageSliderPresenter(router: self.unownedRouter, images: images))
    viewController.modalPresentationStyle = .fullScreen
    viewController.modalTransitionStyle = .coverVertical
    return .present(viewController)
  }
}
