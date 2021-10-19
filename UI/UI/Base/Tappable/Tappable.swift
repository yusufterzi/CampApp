//
//  Tappable.swift
//  YTUI
//
//  Created by yusuf terzi on 4.10.2021.
//

import Foundation
import Common
import UIKit
import ActionKit

public protocol Tappable {
}

public extension Tappable where Self: UIView {

  func onTap(handler: @escaping VoidHandler) {
    let tap = UITapGestureRecognizer() {
      handler()
    }
    addGestureRecognizer(tap)
    isUserInteractionEnabled = true
  }

}
