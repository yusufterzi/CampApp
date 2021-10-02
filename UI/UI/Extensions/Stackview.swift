//
//  Stackview.swift
//  YTUI
//
//  Created by yusuf terzi on 1.10.2021.
//

import Foundation
import UIKit

public extension UIStackView {
  func removeArrangedSubviews() {
    arrangedSubviews.forEach {
      $0.removeFromSuperview()
    }
  }
}
