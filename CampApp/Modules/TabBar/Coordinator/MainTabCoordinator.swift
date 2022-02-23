//
//  MainTabCoordinator.swift
//  CampApp
//
//  Created by yusuf terzi on 22.09.2021.
//

import XCoordinator

enum MainTabRoute: Route {
    case home(category: Int?)
  case search
  case favorite
  case profile
}

class MainTabCoordinator: TabBarCoordinator<MainTabRoute> {
    private var homeRouter: StrongRouter<HomeRoute>!
  private lazy var profileRouter = ProfileCoordinator().strongRouter
  private lazy var searchRouter = SearchCoordinator().strongRouter
  private lazy var favouriteRouter = FavouriteCoordinator().strongRouter
  
  init() {
    super.init(rootViewController: UITabBarController(), initialRoute: .home(category: nil))
    rootViewController.modalPresentationStyle = .fullScreen
  }
    
    init(with categoryID: Int?) {
        homeRouter = HomeCoordinator(category: categoryID).strongRouter
      super.init(rootViewController: UITabBarController(), initialRoute: .home(category: categoryID))
      rootViewController.modalPresentationStyle = .fullScreen
    }
  
  override func prepareTransition(for route: MainTabRoute) -> TabBarTransition{
    switch route {
    case .home(let category):
      return .multiple(.set([homeRouter, searchRouter, favouriteRouter, profileRouter]),.select(homeRouter))
    case .search:
      return .select(searchRouter)
    case .favorite:
      return .select(favouriteRouter)
    case .profile:
      return .select(profileRouter)
    }
  }
}
