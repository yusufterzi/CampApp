//
//  CampDetailDistancePresenter.swift
//  YTUI
//
//  Created by yusuf terzi on 6.10.2021.
//

import UIKit

public protocol CampDetailDistancePresenterProtocol {
  var size: CGSize { get }
  var image: String { get }
  var cornerRadius: CGFloat { get }
}

public final class CampDetailDistancePresenter: CampDetailDistancePresenterProtocol {
  public var size: CGSize
  public var image: String
  public var cornerRadius: CGFloat
  
  public init(size: CGSize, image: String, cornerRadius: CGFloat) {
    self.size = size
    self.image = image
    self.cornerRadius = cornerRadius
  }
  
}
