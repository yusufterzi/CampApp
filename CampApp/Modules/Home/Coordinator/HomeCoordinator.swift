//
//  HomeCoordinator.swift
//  CampApp
//
//  Created by yusuf terzi on 22.09.2021.
//

import XCoordinator
import YTNetwork
import YTUI
import FirebaseUI

enum HomeRoute: Route {
    case home(category: Int?)
    case campDetail(CampComponentViewModel)
    case imageSlider ([StorageReference])
    case back
}

class HomeCoordinator: NavigationCoordinator<HomeRoute> {
        
    init(category: Int?) {
        super.init(initialRoute: .home(category: category))
    }
    
    override func prepareTransition(for route: HomeRoute) -> NavigationTransition {
        switch route {
        case .home(let category):
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
            viewController.modalPresentationStyle = .fullScreen
            viewController.modalTransitionStyle = .coverVertical
            return .present(viewController)
            
        case .back:
            return .pop()
        }
    }
}
