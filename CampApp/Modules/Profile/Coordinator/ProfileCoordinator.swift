//
//  ProfileCoordinator.swift
//  CampApp
//
//  Created by yusuf terzi on 22.09.2021.
//

import XCoordinator

enum ProfileRoute: Route {
    case profile
    case addCampArea
    case maps
}

class ProfileCoordinator: NavigationCoordinator<ProfileRoute> {
    init() {
        super.init(initialRoute: .profile)
    }
    
    override func prepareTransition(for route: ProfileRoute) -> NavigationTransition {
        switch route {
        case .profile:
            let viewController = ProfileController()
            viewController.setupPresenter(presenter: ProfilePresenter(view: viewController,
                                                                      router: self.unownedRouter))
            viewController.tabBarItem = UITabBarItem(title: Tabs.profile.name,
                                                     image: Tabs.profile.image,
                                                     tag: Tabs.profile.tag)
            
            return .push(viewController)
        case .addCampArea:
            let viewController = CampAddingController()
            viewController.setupPresenter(presenter: CampAddingPresenter(view: viewController, router: self.unownedRouter))
            return .push(viewController)
        case .maps:
            let viewController = MapViewController(nibName: "MapViewController", bundle: nil)
            viewController.setupPresenter(presenter: MapViewPresenter(router: self.unownedRouter))
            viewController.hidesBottomBarWhenPushed = true
            
            return .push(viewController)
        }
    }
}


