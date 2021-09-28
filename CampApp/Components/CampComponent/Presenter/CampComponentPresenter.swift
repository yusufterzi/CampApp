//
//  CampComponentPresenter.swift
//  CampApp
//
//  Created by yusuf terzi on 24.09.2021.
//

import Foundation

final class CampComponentPresenter: BaseComponentPresenter {

  var view: CampComponentView?
  var interactor: BaseInteractor?
  
  var item: CampModel?
  
  var point: String {
    return String(format: "%.1f", item?.point ?? 0)
  }
  
  var location: String {
    return (item?.subLocation ?? "") + "/" + (item?.city ?? "")
  }
}
