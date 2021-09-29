//
//  HomeCoordinator.swift
//  CampApp
//
//  Created by yusuf terzi on 22.09.2021.
//

import XCoordinator

enum HomeRoute: Route {
  case home
}

class HomeCoordinator: NavigationCoordinator<HomeRoute> {
  init() {
    super.init(initialRoute: .home)
  }
  
  override func prepareTransition(for route: HomeRoute) -> NavigationTransition {
    switch route {
    case .home:
      let viewController = HomeController()
      viewController.setupPresenter(presenter: HomePresenter(view: viewController,
                                                             router: self.unownedRouter))
      viewController.tabBarItem = UITabBarItem(title: Tabs.home.name,
                                               image: Tabs.home.image,
                                               tag: Tabs.home.tag)
      viewController.view.backgroundColor = UIColor.white
      return .push(viewController)
    }
  }
}
