//
//  ImagePresenter.swift
//  YTUI
//
//  Created by yusuf terzi on 4.10.2021.
//

import UIKit

public protocol ImagePresenterProtocol {
  var size: CGSize { get }
  var image: String { get }
  var cornerRadius: CGFloat { get }
}

public final class ImagePresenter: ImagePresenterProtocol {
  public var size: CGSize
  public var image: String
  public var cornerRadius: CGFloat
  
  public init(size: CGSize, image: String, cornerRadius: CGFloat) {
    self.size = size
    self.image = image
    self.cornerRadius = cornerRadius
  }
  
}
