//
//  TwoRowIconedLabelPresenter.swift
//  YTUI
//
//  Created by yusuf terzi on 6.10.2021.
//

import UIKit

public final class TwoRowIconedLabelPresenter {

  var title: String
  var secondTitle: String
  var image: UIImage
  var imageTintColor: UIColor? = nil

  public init(title: String, secondTitle: String, image: UIImage) {
    self.title = title
    self.secondTitle = secondTitle
    self.image = image
  }
}
