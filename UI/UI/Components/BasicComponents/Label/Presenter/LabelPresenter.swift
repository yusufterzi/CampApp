//
//  LabelPresenter.swift
//  YTUI
//
//  Created by yusuf terzi on 2.10.2021.
//

import Foundation
import UIKit

public protocol LabelPresenterProtocol {
  var font: UIFont { get set }
  var textColor: UIColor { get set }
  var text: String { get set }
  var insets: UIEdgeInsets { get set }
}

public final class LabelPresenter: LabelPresenterProtocol {
  public var font: UIFont
  public var textColor: UIColor
  public var text: String
  public var insets: UIEdgeInsets

  public init(font: UIFont, textColor: UIColor,
              text: String, insets: UIEdgeInsets) {
    self.font = font
    self.textColor = textColor
    self.text = text
    self.insets = insets
  }
}
