//
//  FavouriteCoordinator.swift
//  CampApp
//
//  Created by yusuf terzi on 22.09.2021.
//

import XCoordinator

enum FavouriteRoute: Route {
  case favorite
}

class FavouriteCoordinator: NavigationCoordinator<FavouriteRoute> {
  init() {
    super.init(initialRoute: .favorite)
  }
  
  override func prepareTransition(for route: FavouriteRoute) -> NavigationTransition {
    switch route {
    case .favorite:
      let viewController = ViewController()
      viewController.tabBarItem = UITabBarItem(title: Tabs.favorite.name,
                                               image: Tabs.favorite.image,
                                               tag: Tabs.favorite.tag)
      return .push(viewController)
   
    }
  }
}
