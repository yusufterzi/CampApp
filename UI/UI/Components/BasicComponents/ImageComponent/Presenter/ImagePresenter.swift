//
//  ImagePresenter.swift
//  YTUI
//
//  Created by yusuf terzi on 4.10.2021.
//

import UIKit
import FirebaseStorageUI

public class ImageViewModel {
  public var size: CGSize
  public var imageReference: StorageReference
  public var cornerRadius: CGFloat
  public var contentMode: UIView.ContentMode = .scaleAspectFit
  
  public init(size: CGSize, imageReference: StorageReference, cornerRadius: CGFloat, contentMode: UIView.ContentMode) {
    self.size = size
    self.imageReference = imageReference
    self.cornerRadius = cornerRadius
    self.contentMode = contentMode
  }
}

public protocol ImagePresenterProtocol {
  var item: ImageViewModel { get }
}

public final class ImagePresenter: ImagePresenterProtocol {
  
  public var item: ImageViewModel
  
  public init(item: ImageViewModel) {
    self.item = item
  }
}
