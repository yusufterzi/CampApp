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
import FirebaseUI

enum FavouriteRoute: Route {
  case favorite
  case campDetail(CampComponentViewModel)
  case imageSlider ([StorageReference])
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
      return .dismiss()
    case .imageSlider(let images):
      return .dismiss()
    case .back:
      return .pop()
    case .dismiss:
      return .dismiss()
    }
  }
  
}
