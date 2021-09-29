//
//  CampComponentPresenter.swift
//  CampApp
//
//  Created by yusuf terzi on 24.09.2021.
//

import Foundation
import YTNetwork

public final class CampComponentPresenter: BaseComponentPresenter {

  public var view: CampComponentViewProtocol?
  public var interactor: BaseInteractor?
  
  private var item: CampModel
  
  var point: String {
    String(format: "%.1f", item.point ?? 0)
  }
  
  var location: String {
    (item.subLocation ?? "") + "/" + (item.city ?? "")
  }
  
  var image: String {
    item.images?.first ?? ""
  }
  
  public init(item: CampModel) {
    self.item = item
  }
}
