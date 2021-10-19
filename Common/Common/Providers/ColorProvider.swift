//
//  ColorProvider.swift
//  CampApp
//
//  Created by yusuf terzi on 24.09.2021.
//

import Foundation
import UIKit

public enum ColorProvider: String {
  case greenLabel
  case darkTextColor
  case blackTextColor
  case segmentSelectedColor
  case segmentItemSelectedText
  case lightTextColor
  case whiteTextColor
  case locationBgColor
  case semiDarkTextColor
  case darkGrayTextColor
  case starYellow
  case semiTransparentBg
  case lowTextColor
  case highTextColor

  public var color: UIColor {
    return colorFromName(self.rawValue)
  }
  
  private func colorFromName(_ name: String) -> UIColor {
    return UIColor(named: name, in: Bundle.main, compatibleWith: nil)!
  }
}
