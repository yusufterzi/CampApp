//
//  CampDetailCoordinator.swift
//  CampApp
//
//  Created by yusuf terzi on 29/04/2022.
//

import XCoordinator
import YTNetwork
import YTUI
import Common
import FirebaseStorageUI

enum CampDetailRoute: Route {
  case initialize(CampComponentViewModel)
  case imageSlider ([StorageReference])
  case editCampArea(CampModel)
  case addCampArea(CampModel, [UIImage])
  case maps(_ handler: Handler<Location>?)
  case back
  case dismiss
}

class CampDetailCoordinator: NavigationCoordinator<CampDetailRoute> {
  
  init(camp: CampComponentViewModel, root: RootViewController) {
    super.init(rootViewController: root)
    self.trigger(.initialize(camp))
  }
  
  init(camp: CampModel, root: RootViewController) {
    super.init(rootViewController: root)
    self.trigger(.editCampArea(camp))
  }
  
  init(camp: CampModel, images: [UIImage], root: RootViewController) {
    super.init(rootViewController: root)
    self.trigger(.addCampArea(camp, images))
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
    case .editCampArea(let campModel):
        let viewController = CampAddingController()
        let presenter = CampAddingPresenter(view: viewController, router: self.unownedRouter, camp: campModel)
        viewController.setupPresenter(presenter: presenter)
        return .push(viewController)
    case .maps(let handler):
        let viewController = MapViewController()
        viewController.setupPresenter(presenter: MapViewPresenter(router: self.unownedRouter))
        viewController.comletionHandler = handler
        viewController.hidesBottomBarWhenPushed = true
        return .push(viewController)
    case .addCampArea(let campModel, let images):
      let viewController = CampAddingController()
      let presenter = CampAddingPresenter(view: viewController, router: self.unownedRouter, camp: campModel)
      presenter.campGoogleImages = images
      viewController.setupPresenter(presenter: presenter)
      return .push(viewController)
    }
  }

  private func showCampDetailController(item: CampComponentViewModel) -> NavigationTransition {
    let viewController = CampDetailController()
    viewController.setupPresenter(presenter: CampDetailPresenter(view: viewController,
                                                                 router: self.unownedRouter,
                                                                 item: item))
    viewController.hidesBottomBarWhenPushed = true
    return .push(viewController, animation: .default)
    
  }
  private func showImageSlider(images: [StorageReference]) -> NavigationTransition {
    let viewController = ImageSliderController.instantiate()
    viewController.setupPresenter(presenter: ImageSliderPresenter(router: self.unownedRouter, images: images))
    viewController.modalPresentationStyle = .fullScreen
    viewController.modalTransitionStyle = .coverVertical
    return .present(viewController)
  }
  
  private func editCampDetail() {
    
  }
}
