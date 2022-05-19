//
//  HomeCoordinator.swift
//  CampApp
//
//  Created by yusuf terzi on 22.09.2021.
//

import XCoordinator
import YTNetwork
import YTUI
import FirebaseStorageUI

enum HomeRoute: Route {
  case home(category: Int?)
  case campDetail(CampComponentViewModel)
  case back
  case dismiss
  case campsForMe
}

class HomeCoordinator: NavigationCoordinator<HomeRoute> {
  
  init(category: Int?) {
    super.init(initialRoute: .home(category: category))
  }
  
  override func prepareTransition(for route: HomeRoute) -> NavigationTransition {
    switch route {
    case .home(let category):
      return showHomeController(with: category)
    case .campDetail(let item):
      return showCampDetailController(item: item)
    case .back:
      return .pop()
    case .dismiss:
      return .dismiss()
    case .campsForMe:
      return showForMeController()
    }
  }
  
  private func showForMeController() -> NavigationTransition {
    let viewController = CampAreasForMeController()
    viewController.setupPresenter(presenter: CampAreasForMePresenter(view: viewController,
                                                           router: self.unownedRouter))
    return .present(viewController)
  }
  
  private func showHomeController(with category: Int?) -> NavigationTransition {
    let viewController = HomeController()
    viewController.setupPresenter(presenter: HomePresenter(view: viewController,
                                                           router: self.unownedRouter, selectedSegment: category))
    viewController.tabBarItem = UITabBarItem(title: Tabs.home.name,
                                             image: Tabs.home.image,
                                             tag: Tabs.home.tag)
    return .push(viewController)
  }
  
  private func showCampDetailController(item: CampComponentViewModel) -> NavigationTransition {
    let coordinator = CampDetailCoordinator(camp: item, root: self.rootViewController)
    addChild(coordinator)
    return .none()
  }

}
