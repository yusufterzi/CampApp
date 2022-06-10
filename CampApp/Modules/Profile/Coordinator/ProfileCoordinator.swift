//
//  ProfileCoordinator.swift
//  CampApp
//
//  Created by yusuf terzi on 22.09.2021.
//

import XCoordinator
import YTNetwork
import Common
import AttributedStringBuilder

enum ProfileRoute: Route {
    case profile
    case addCampArea(CampModel, [UIImage])
    case searchCampArea
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
        case .searchCampArea:
            let viewController = SearchPlaceController()
            viewController.setupPresenter(presenter: SearchPlacePresenter(view: viewController, router: self.unownedRouter))
            return .push(viewController)
        case .addCampArea(let campModel, let campImages):
          let coordinator = CampDetailCoordinator(camp: campModel, images: campImages, root: self.rootViewController)
          addChild(coordinator)
          return .none()

        case .back:
            return .pop()
        }
    }
}


