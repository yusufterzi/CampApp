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
  
  func setup(_ slide: WelcomeData, frameView: UIView)  {
    imageView.image = slide.image
    //imageView.applyBlurEffect(style: .dark)
  }
  
}
