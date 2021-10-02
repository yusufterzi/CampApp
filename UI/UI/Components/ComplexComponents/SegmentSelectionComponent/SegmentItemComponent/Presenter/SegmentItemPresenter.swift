//
//  SegmentItemPresenter.swift
//  YTUI
//
//  Created by yusuf terzi on 30.09.2021.
//

import Foundation
import AttributedStringBuilder
import Common

public protocol SegmentItemPresenterProtocol {
  var name: String { get set }
  var identifier: Int { get set }
  var isSelected: Bool { get set }
  
  var titleColor: UIColor { get }
  var backgroundColor: UIColor { get }
  var font: UIFont { get }
}

public final class SegmentItemPresenter: SegmentItemPresenterProtocol {
  public var name: String
  public var identifier: Int
  public var isSelected: Bool
  
  public var titleColor: UIColor {
    if isSelected {
      return ColorProvider.segmentItemSelectedText.color
    } else {
      return ColorProvider.lightTextColor.color
    }
  }
  
  public var backgroundColor: UIColor {
    if isSelected {
      return ColorProvider.segmentSelectedColor.color
    } else {
      return .clear
    }
  }
  
  public var font: UIFont {
    if isSelected {
      return FontProvider.segmentBold
    } else {
      return FontProvider.segmentRegular
    }
  }

  public init(identifier: Int, name: String, isSelected: Bool) {
    self.identifier = identifier
    self.name = name
    self.isSelected = isSelected
  }
}
