//
//  CampComponentPresenter.swift
//  CampApp
//
//  Created by yusuf terzi on 24.09.2021.
//

import Foundation
import YTNetwork

public protocol CampComponentPresenterProtocol {
  var point: String { get }
  var location: String { get }
  var image: String { get }
}

public final class CampComponentPresenter: CampComponentPresenterProtocol {

  private var item: CampModel
  
  public var point: String {
    String(format: "%.1f", item.point ?? 0)
  }
  
  public var location: String {
    (item.subLocation ?? "") + "/" + (item.city ?? "")
  }
  
  public var image: String {
    item.images?.first ?? ""
  }
  
  public init(item: CampModel) {
    self.item = item
  }
}
