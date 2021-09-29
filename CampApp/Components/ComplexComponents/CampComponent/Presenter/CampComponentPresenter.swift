//
//  CampComponentPresenter.swift
//  CampApp
//
//  Created by yusuf terzi on 24.09.2021.
//

import Foundation

public final class CampComponentPresenter: BaseComponentPresenter {

  public var view: CampComponentView?
  public var interactor: BaseInteractor?
  
  var item: CampModel
  
  var point: String {
    return String(format: "%.1f", item.point ?? 0)
  }
  
  var location: String {
    return (item.subLocation ?? "") + "/" + (item.city ?? "")
  }
  
  init(item: CampModel) {
    self.item = item
  }
}
