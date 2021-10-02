//
//  YTCarouselPresenter.swift
//  YTUI
//
//  Created by yusuf terzi on 1.10.2021.
//

import Foundation
import AttributedStringBuilder
import Common
import YTNetwork

public protocol YTCarouselPresenterProtocol {
  var items: [CampModel] { get set }
  var index: Int { get set }
  
  var image: String { get }
  var point: String { get }
  var location: String { get }
  var velocityArray: [CGFloat] { get set }

  var gestureStartPoint: CGPoint { get set }
  var gestureLastPoint: CGPoint { get set }
  
  func addVelocity(value: CGFloat)
}

public final class YTCarouselPresenter: YTCarouselPresenterProtocol {
  public var items: [CampModel]
  public var index: Int = 0

  public var gestureStartPoint: CGPoint = CGPoint(x: 0, y: 0)
  public var gestureLastPoint: CGPoint = CGPoint(x: 0, y: 0)
  public var velocityArray: [CGFloat] = .init()

  public init(items: [CampModel]) {
    self.items = items
  }
  
  private var item: CampModel {
    return items[index]
  }
  
  public var point: String {
    String(format: "%.1f", item.point ?? 0)
  }
  
  public var location: String {
    (item.subLocation ?? "") + "/" + (item.city ?? "")
  }
  
  public var image: String {
    item.images?.first ?? ""
  }
  
  public var nextImage: String {
    item.images?.first ?? ""
  }
  
  public var prevImage: String {
    item.images?.first ?? ""
  }
  
  public func addVelocity(value: CGFloat) {
    velocityArray.append(value)
    
    if velocityArray.count > 10 {
      velocityArray.removeFirst()
    }
  }
  
}

