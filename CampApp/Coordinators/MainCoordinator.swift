//
//  MainCoordinator.swift
//  CampApp
//
//  Created by yusuf terzi on 22.09.2021.
//

import XCoordinator
import Common

enum MainRoute: Route {
    case home
    case welcome
    case campSelection
}
final class MainCoordinator: NavigationCoordinator<MainRoute> {
    private var initialRoute: RouteType = .home
    init() {
        CampDefaults.setup(with: PersistentDomain.test)
        let appFirstLaunch : Bool = CampDefaults.shared.retrieve(with: .appFirstLaunch) ?? true
        if appFirstLaunch {
            CampDefaults.shared.storeFlag(with: .appFirstLaunch, value: false)
            initialRoute = .welcome
        }
        super.init(initialRoute: initialRoute)
    }
    
    override func prepareTransition(for route: MainRoute) -> NavigationTransition {
        switch route {
        case .home:
            rootViewController.navigationBar.isHidden = true
            let coordinator = MainTabCoordinator(with: nil)
            addChild(coordinator)
            return .push(coordinator.rootViewController)
        case .welcome:
            rootViewController.navigationBar.isHidden = true
            let viewController = WelcomeController.instantiate()
            viewController.setupPresenter(presenter: WelcomePresenter(router: self.unownedRouter))
            return .push(viewController)
        case .campSelection:
            rootViewController.navigationBar.isHidden = true
            let viewController = CampSelectionController.instantiate()
            viewController.setupPresenter(presenter: CampSelectionPresenter(router: self.unownedRouter))
            return .push(viewController)
            
        }
        
    }
}
