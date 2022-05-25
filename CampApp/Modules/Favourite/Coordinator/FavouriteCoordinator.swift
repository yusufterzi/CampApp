//
//  FavouriteCoordinator.swift
//  CampApp
//
//  Created by yusuf terzi on 22.09.2021.
//

import XCoordinator
import Common
import YTNetwork
import YTUI

enum FavouriteRoute: Route {
  case favorite
  case campDetail(CampComponentViewModel)
  case back
  case dismiss
}

class FavouriteCoordinator: NavigationCoordinator<FavouriteRoute> {
  init() {
    super.init(initialRoute: .favorite)
  }
  
  override func prepareTransition(for route: FavouriteRoute) -> NavigationTransition {
    switch route {
    case .favorite:
      let viewController = FavoriteController()
      viewController.tabBarItem = UITabBarItem(title: Tabs.favorite.name,
                                               image: Tabs.favorite.image,
                                               tag: Tabs.favorite.tag)
      viewController.setupPresenter(presenter: FavoritePresenter(view: viewController, router: self.unownedRouter))
      return .push(viewController)
    case .campDetail(let item):
      return showCampDetailController(item: item)
    case .back:
      return .pop()
    case .dismiss:
      return .dismiss()
    }
  }
  
  private func showCampDetailController(item: CampComponentViewModel) -> NavigationTransition {
    let coordinator = CampDetailCoordinator(camp: item, root: self.rootViewController)
    addChild(coordinator)
    return .none()
  }
  
}
