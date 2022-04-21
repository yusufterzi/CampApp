//
//  SearchPlaceCoordinator.swift
//  CampApp
//
//  Created by yusuf terzi on 21.04.2022.
//

import XCoordinator
import YTNetwork
import YTUI
import FirebaseUI

enum SearchPlaceRoute: Route {
  case searchPlace
  case back
}

class SearchPlaceCoordinator: NavigationCoordinator<SearchPlaceRoute> {
        
  init(category: Int?) {
    super.init(initialRoute: .searchPlace)
  }
    
  override func prepareTransition(for route: SearchPlaceRoute) -> NavigationTransition {
    switch route {
    case .searchPlace:
      return .pop()
    case .back:
      return .pop()
    }
  }
}
