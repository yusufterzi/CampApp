//
//  CampAreaItemPresenter.swift
//  YTUI
//
//  Created by yusuf terzi on 3.10.2021.
//

import Foundation
import Common

public protocol CampAreaItemPresenterProtocol {
  var name: String { get set }
  var image: String { get set }
  var areaCount: Int { get set }

}

public final class CampAreaItemPresenter: CampAreaItemPresenterProtocol {
  public var name: String
  public var image: String
  public var areaCount: Int
  public init(name: String, image: String, areaCount: Int) {
    self.name = name
    self.image = image
    self.areaCount = areaCount
  }
}
