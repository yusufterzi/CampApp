//
//  WelcomeCell.swift
//  CampApp
//
//  Created by Nurullah Vural on 14.02.2022.
//

import UIKit
import Foundation

final class WelcomeCell: UICollectionViewCell {
  
  static let identifier = String(describing: WelcomeCell.self)
  @IBOutlet private var imageView: UIImageView!
  
  func setup(_ data: WelcomeData, frameView: UIView)  {
    imageView.image = data.image
    
    let roundedRect = CGRect (
      x: frameView.frame.minX,
      y: frameView.frame.minY,
      width: frameView.bounds.size.width ,
      height: frameView.bounds.size.height
    );
    
    let path = UIBezierPath(rect: self.view.bounds)
    let croppedPath = UIBezierPath(roundedRect: roundedRect, cornerRadius: 16)
    path.append(croppedPath)
    path.usesEvenOddFillRule = true
    
    let maskLayer = CAShapeLayer()
    maskLayer.path = path.cgPath;
    maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
    imageView.applyBlurredMask(style: .dark, maskLayer: maskLayer)
    
  }
  
}
