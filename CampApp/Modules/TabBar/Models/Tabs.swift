//
//  Tabs.swift
//  CampApp
//
//  Created by yusuf terzi on 22.09.2021.
//

import UIKit

enum Tabs: Int {
  case home = 0, search, favorite, profile

  var image: UIImage {
    switch self {
    case .home: return ImageProvider.tabHome
    case .search: return ImageProvider.tabSearch
    case .favorite: return ImageProvider.tabFavorite
    case .profile: return ImageProvider.tabProfile
    }
  }

  var name: String {
    switch self {
    case .home: return StringProvider.tabHome
    case .search: return StringProvider.tabSearch
    case .favorite: return StringProvider.tabFavorite
    case .profile: return StringProvider.tabProfile
    }
  }

  var tag: Int {
    return self.rawValue
  }

}
