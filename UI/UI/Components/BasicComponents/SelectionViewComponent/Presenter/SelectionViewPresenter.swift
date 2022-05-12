//
//  SelectionViewPresenter.swift
//  YTUI
//
//  Created by Nurullah Vural on 10.05.2022.
//

import Foundation
import UIKit
import Common

public protocol SelectionItemProtocol {
  var id: Int { get }
  var text: String { get }
  
}

public enum CampAreaEnum: Int, SelectionItemProtocol {
  
  
  case ege = 0, karadeniz, akdeniz, marmara, icAnadolu, doguAnadolu
  
  public var text: String {
    switch self {
    case .ege: return StringProvider.ege
    case .karadeniz: return StringProvider.karadeniz
    case .akdeniz: return StringProvider.akdeniz
    case .marmara: return StringProvider.marmara
    case .icAnadolu: return StringProvider.icAnadolu
    case .doguAnadolu: return StringProvider.doguAnadolu
    }
  }
  
  public var id: Int {
    return self.rawValue
  }
  
}

public enum CampTypeEnum: Int , SelectionItemProtocol{
  
  case caravan = 0, tent, bungalow, all
  
  public var text: String {
    switch self {
    case .caravan: return StringProvider.caravanAreas
    case .tent: return StringProvider.tentAreas
    case .bungalow: return StringProvider.bungalowAreas
    case .all: return StringProvider.allCampAreas
    }
  }
  
  public var id: Int {
    return self.rawValue
  }
  
}


public protocol SelectionViewPresenterProtocol {
  var header: String { get set }
  var itemList : [SelectionItemProtocol] { get set }
  var multipleSelection: Bool { get set }
  var selectionHandler: Handler<[SelectionRowPresenter]>? { get set }
  
}


public final class SelectionViewPresenter: SelectionViewPresenterProtocol {
  public var header: String
  public var itemList: [SelectionItemProtocol]
  public var multipleSelection: Bool
  public var selectionHandler: Handler<[SelectionRowPresenter]>?
  
  public init(header: String, itemList: [SelectionItemProtocol], multipleSelection: Bool) {
    self.header = header
    self.itemList = itemList
    self.multipleSelection = multipleSelection
  }
}
