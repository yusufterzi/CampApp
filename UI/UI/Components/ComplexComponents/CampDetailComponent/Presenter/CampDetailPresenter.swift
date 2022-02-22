//
//  CampDetailPresenter.swift
//  YTUI
//
//  Created by yusuf terzi on 3.10.2021.
//

import Foundation
import YTNetwork
import Carbon
import Common

public protocol CampDetailComponentPresenterProtocol {
  var point: String { get }
  var location: String { get }
  var images: [String] { get }
  var name: String { get }
  var sections: [Section] { get }
  var description: String { get }
  var imageIndex: Int { get set }
  var backButtonTapped: VoidHandler? { get set }
  var maximizeButtonTapped: Handler<[String]>? { get set }
}

public final class CampDetailComponentPresenter: CampDetailComponentPresenterProtocol {
  public var backButtonTapped: VoidHandler?
  public var maximizeButtonTapped: Handler<[String]>?
  private var item: CampModel
  public var imageIndex: Int = 0 
  
  public var point: String {
    String(format: "%.1f", item.point ?? 0)
  }
  
  public var location: String {
    (item.subLocation ?? "") + "/" + (item.city ?? "")
  }

  public var images: [String] {
    return item.images ?? []
  }
  
  public init(item: CampModel) {
    self.item = item
  }
  
  public var name: String {
    item.name ?? ""
  }
  public var description:  String {
      item.description ?? ""
  }
  
  public var sections: [Section] {
    
    let width = UIScreen.main.bounds.width
    
    var cells: [CellNode] = .init()
    for item in item.images ?? [] {
      let presenter = ImagePresenter(size: CGSize(width: width, height: 350),
                                     image: item, cornerRadius: 0)
      let imageComponent = ImageComponent(id: "", presenter: presenter)
      let cell = CellNode(imageComponent)
      cells.append(cell)
    }
    let section = Section(id: "", header: nil, cells: cells, footer: nil)
    
    return [section]
  }
}
