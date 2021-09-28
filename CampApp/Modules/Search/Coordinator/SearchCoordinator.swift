//
//  SearchCoordinator.swift
//  CampApp
//
//  Created by yusuf terzi on 22.09.2021.
//

import XCoordinator

enum SearchRoute: Route {
  case search
}

class SearchCoordinator: NavigationCoordinator<SearchRoute> {
  init() {
    super.init(initialRoute: .search)
  }
  
  override func prepareTransition(for route: SearchRoute) -> NavigationTransition {
    switch route {
    case .search:
      let viewController = ViewController()
      viewController.tabBarItem = UITabBarItem(title: Tabs.search.name,
                                               image: Tabs.search.image,
                                               tag: Tabs.search.tag)
      return .push(viewController)
    }
  }
}
