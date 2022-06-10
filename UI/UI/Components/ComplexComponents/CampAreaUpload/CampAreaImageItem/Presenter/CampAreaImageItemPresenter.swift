//
//  CampAreaImageItemPresenter.swift
//  YTUI
//
//  Created by Nurullah Vural on 4.03.2022.
//

import Foundation
import Common
import AttributedStringBuilder

public protocol CampAreaImageItemPresenterProtocol {
  var image: UIImage? { get set }
  var addImage: UIImage? { get set }
  var removeImage: UIImage? { get set }
  var text: String? { get set }
  var addImageHandler: Handler<UIImage>? { get set }
  var removeImageHandler: Handler<UIImage>? { get set }
  var longPressHandler: VoidHandler? { get set }
  
  
}

public final class CampAreaImageItemPresenter: CampAreaImageItemPresenterProtocol {
  public var image: UIImage?
  public var addImage: UIImage?
  public var removeImage: UIImage?
  public var text: String?
  public var addImageHandler: Handler<UIImage>?
  public var removeImageHandler: Handler<UIImage>?
  public var longPressHandler: VoidHandler?

  public init(image: UIImage?, addImage: UIImage?, removeImage: UIImage?, text: String?) {
    self.image = image
    self.addImage = addImage
    self.removeImage = removeImage
    self.text = text
  }
}
