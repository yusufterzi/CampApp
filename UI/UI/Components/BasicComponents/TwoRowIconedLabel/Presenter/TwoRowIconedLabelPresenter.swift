//
//  TwoRowIconedLabelPresenter.swift
//  YTUI
//
//  Created by yusuf terzi on 6.10.2021.
//

import UIKit
import Common

public final class TwoRowIconedLabelPresenter {

  var title: String
  var secondTitle: String
  var image: UIImage
  var imageTintColor: UIColor? = nil
  var onTap: VoidHandler?

  public init(title: String, secondTitle: String, image: UIImage) {
    self.title = title
    self.secondTitle = secondTitle
    self.image = image
  }
}
