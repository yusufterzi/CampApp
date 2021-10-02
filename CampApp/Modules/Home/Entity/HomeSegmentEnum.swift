//
//  HomeSegmentEnum.swift
//  CampApp
//
//  Created by yusuf terzi on 30.09.2021.
//

import Common

enum HomeSegmentEnum: Int {
  case all
  case caravan
  case tent
  case bungalow
  
  var title: String {
    switch self {
    case .all:
      return StringProvider.allCampAreas
    case .caravan:
      return StringProvider.caravanAreas
    case .tent:
      return StringProvider.tentAreas
    case .bungalow:
      return StringProvider.bungalowAreas
    }
  }
}
