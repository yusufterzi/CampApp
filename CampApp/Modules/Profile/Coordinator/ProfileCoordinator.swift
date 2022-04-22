//
//  ProfileCoordinator.swift
//  CampApp
//
//  Created by yusuf terzi on 22.09.2021.
//

import XCoordinator
import YTNetwork
import Common

enum ProfileRoute: Route {
    case profile
    case addCampArea
    case maps(_ handler: Handler<Location>?)
    case back
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
            let viewController = SearchPlaceController()
            viewController.setupPresenter(presenter: SearchPlacePresenter(view: viewController, router: self.unownedRouter))
            return .push(viewController)
        case .maps(let handler):
            let viewController = MapViewController()
            viewController.setupPresenter(presenter: MapViewPresenter(router: self.unownedRouter))
            viewController.comletionHandler = handler
            viewController.hidesBottomBarWhenPushed = true
            return .push(viewController)
        case .back:
            return .pop()
        }
    }
}


