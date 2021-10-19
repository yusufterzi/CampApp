//
//  CampAreaComponentPresenter.swift
//  YTUI
//
//  Created by yusuf terzi on 2.10.2021.
//

import Foundation
import YTNetwork
import Carbon

public protocol CampAreaComponentPresenterProtocol {
  var sections: [Section] { get }
  var items: [CampAreaModel] { get set }
}

public final class CampAreaComponentPresenter: CampAreaComponentPresenterProtocol {
  public var items: [CampAreaModel]
  
  public init(items: [CampAreaModel]) {
    self.items = items
  }
  
  public var sections: [Section] {
    
    var cells: [CellNode] = .init()
    for item in items {
      cells.append(CellNode(CampAreaItemComponent(id: "",
                                                  presenter: CampAreaItemPresenter(
                                                    name: item.name ?? "",
                                                    image: item.images?.first ?? "",
                                                    areaCount: item.camps?.count ?? 0))))
    }
    let section = Section(id: "", header: nil, cells: cells, footer: nil)
    
    return [section]
  }
}
