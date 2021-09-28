//
//  MainCoordinator.swift
//  CampApp
//
//  Created by yusuf terzi on 22.09.2021.
//

import XCoordinator

enum MainRoute: Route {
  case home
  case welcome
}

class MainCoordinator: NavigationCoordinator<MainRoute> {
  
  init() {
    super.init(initialRoute: .home)
  }
  
  override func prepareTransition(for route: MainRoute) -> NavigationTransition {
    switch route {
    case .home:
      let coordinator = MainTabCoordinator()
      addChild(coordinator)

        
      return .push(coordinator.rootViewController)
    case .welcome:
      let viewController = ViewController()
      return .push(viewController)
      
    }
  }
}
