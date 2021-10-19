//
//  Label.swift
//  CampApp
//
//  Created by yusuf terzi on 24.09.2021.
//

import UIKit

public final class Label: UILabel {
  
  @objc public dynamic var edgeInsets = UIEdgeInsets.zero {
    didSet {
      setNeedsLayout()
      invalidateIntrinsicContentSize()
    }
  }
  
  override public func drawText(in rect: CGRect) {
    super.drawText(in: rect.inset(by: edgeInsets))
  }
  
}
