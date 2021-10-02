//
//  SegmentSelectionPresenter.swift
//  YTUI
//
//  Created by yusuf terzi on 29.09.2021.
//

import Foundation
import Carbon

public final class SegmentItemModel {
  public var identifier: Int
  public var name: String
  public var isSelected: Bool
  
  public init(identifier: Int, name: String, isSelected: Bool) {
    self.identifier = identifier
    self.name = name
    self.isSelected = isSelected
  }
}

public protocol SegmentSelectionPresenterProtocol {
  var sections: [Section] { get }
  
  var items: [SegmentItemModel] { get set }
}

public final class SegmentSelectionPresenter: SegmentSelectionPresenterProtocol {
 
  public var items: [SegmentItemModel]
  
  public init(items: [SegmentItemModel]) {
    self.items = items
  }
  
  public var sections: [Section] {
    
    var cells: [CellNode] = .init()
    for item in items {
      cells.append(CellNode(SegmentItemComponent(id: "",
                                    presenter: SegmentItemPresenter(
                                      identifier: item.identifier,
                                      name: item.name,
                                      isSelected: item.isSelected))))
    }
    let section = Section(id: "", header: nil, cells: cells, footer: nil)
    
    return [section]
  }
}
