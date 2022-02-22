//
//  HomeCoordinator.swift
//  CampApp
//
//  Created by yusuf terzi on 22.09.2021.
//

import XCoordinator
import YTNetwork

enum HomeRoute: Route {
    case home
    case campDetail(CampModel)
    case imageSlider ([String])
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
            return .push(viewController)
        case .campDetail(let item):
            let viewController = CampDetailController()
            viewController.setupPresenter(presenter: CampDetailPresenter(view: viewController,
                                                                         router: self.unownedRouter,
                                                                         item: item))
            return .push(viewController)
        case .imageSlider(let images):
            let viewController = ImageSliderController.instantiate()
            viewController.setupPresenter(presenter: ImageSliderPresenter(router: self.unownedRouter, images: images))
            viewController.modalTransitionStyle = .coverVertical
            return .present(viewController)
            
            
        }
    }
}
