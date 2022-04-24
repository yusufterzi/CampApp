//
//  UIView.swift
//  Common
//
//  Created by Nurullah Vural on 26.02.2022.
//

import Foundation
import UIKit

public extension UIView {
  
  @IBInspectable var cornerRadius: CGFloat {
    get { return self.cornerRadius }
    set {
      self.layer.cornerRadius = newValue
    }
  }
  
  var parentViewController: UIViewController? {
    var parentResponder: UIResponder? = self.next
    while parentResponder != nil {
      if let viewController = parentResponder as? UIViewController {
        return viewController
      }
      parentResponder = parentResponder?.next
    }
    return nil
  }
  
  func addCircleShadow() {
    let roundedShapeLayer = CAShapeLayer()
    roundedShapeLayer.fillColor = UIColor.white.cgColor
    roundedShapeLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 18).cgPath
    
    self.layer.insertSublayer(roundedShapeLayer, at: 0)
    self.layer.shadowOpacity = 0.8
    self.layer.shadowOffset = CGSize(width: 0, height: 2)
    self.layer.shadowRadius = 4
    self.layer.shadowColor = UIColor.darkGray.cgColor
    self.layer.cornerRadius = 18
  }
  func applyBlurEffect(style: UIBlurEffect.Style, cornerRadius: CGFloat = 0) {
    guard self.subviews.first is UIVisualEffectView  else {
      
      self.backgroundColor = .clear
      let blurEffect = UIBlurEffect(style: style)
      let blurEffectView = UIVisualEffectView(effect: blurEffect)
      blurEffectView.frame = self.bounds
      blurEffectView.clipsToBounds = true
      blurEffectView.layer.cornerRadius = cornerRadius
      blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      blurEffectView.alpha = 0.8
      self.insertSubview(blurEffectView, at: 0)
      
      return
    }
 
  }
}
