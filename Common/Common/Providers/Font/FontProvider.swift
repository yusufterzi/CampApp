//
//  FontProvider.swift
//  CampApp
//
//  Created by yusuf terzi on 24.09.2021.
//

import UIKit

private let fontName: String = "Rubik"

public final class FontProvider {
  
  public static let listSmallRegular: UIFont = UIFont(name: fontName + "-Regular", size: 11)!
  public static let listMidMedium: UIFont = UIFont(name: fontName + "-Medium", size: 18)!
  public static let bigHeaderRegular: UIFont = UIFont(name: fontName + "-Regular", size: 28)!
  public static let bigHeaderBold: UIFont = UIFont(name: fontName + "-Bold", size: 28)!
  
  public static let segmentRegular: UIFont = UIFont(name: fontName + "-Regular", size: 12)!
  public static let segmentBold: UIFont = UIFont(name: fontName + "-Bold", size: 12)!

  public static let regular19: UIFont = UIFont(name: fontName + "-Regular", size: 19)!
  public static let regular14: UIFont = UIFont(name: fontName + "-Regular", size: 14)!
  public static let regular12: UIFont = UIFont(name: fontName + "-Regular", size: 12)!

  public static let light10: UIFont = UIFont(name: fontName + "-Light", size: 10)!
}
