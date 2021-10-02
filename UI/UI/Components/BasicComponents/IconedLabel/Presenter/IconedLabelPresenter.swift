//
//  IconedLabelPresenter.swift
//  CampApp
//
//  Created by yusuf terzi on 24.09.2021.
//

import UIKit

public final class IconedLabelPresenter {

  var title: String
  var image: UIImage?
  var textColor: UIColor?
  var textFont: UIFont?
  var space: CGFloat?
  var backgroundColor: UIColor = .clear
  var imageTintColor: UIColor? = nil
  var radius: CGFloat = 0

  public init(title: String, image: UIImage?, textColor: UIColor? = nil) {
    self.title = title
    self.image = image
    self.textColor = textColor
  }
}
