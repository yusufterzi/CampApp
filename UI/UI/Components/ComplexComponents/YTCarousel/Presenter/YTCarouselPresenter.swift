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
import FirebaseUI

public class CampCarouselViewModel {
    public var name: String?
    public var subLocation: String?
    public var city: String?
    public var description: String?
    public var imageReference: [StorageReference]?
    public var latitude: Double?
    public var longitude: Double?
    public var point: Double?
    public var address: String?
    public var id: String

    public init(name: String? = nil, subLocation: String? = nil , city: String? = nil, description: String? = nil, imageReference: [StorageReference]? = nil, latitude: Double? = nil, longitude: Double? = nil, point: Double? = nil, address: String? = nil, id: String) {
        
        self.name = name
        self.subLocation = subLocation
        self.city = city
        self.description = description
        self.imageReference = imageReference
        self.latitude = latitude
        self.longitude = longitude
        self.point = point
        self.address = address
        self.id = id
    }
}


public protocol YTCarouselPresenterProtocol {
  var items: [CampComponentViewModel] { get set }
  var index: Int { get set }
  
  var image: StorageReference { get }
  var point: String { get }
  var location: String { get }
  var velocityArray: [CGFloat] { get set }

  var gestureStartPoint: CGPoint { get set }
  var gestureLastPoint: CGPoint { get set }
  var onTap: VoidHandler? { get set }
  func addVelocity(value: CGFloat)
}

public final class YTCarouselPresenter: YTCarouselPresenterProtocol {
  public var items: [CampComponentViewModel]
  public var index: Int = 0
  public var onTap: VoidHandler?

  public var gestureStartPoint: CGPoint = CGPoint(x: 0, y: 0)
  public var gestureLastPoint: CGPoint = CGPoint(x: 0, y: 0)
  public var velocityArray: [CGFloat] = .init()

  public init(items: [CampComponentViewModel]) {
    self.items = items
  }
  
  private var item: CampComponentViewModel {
    return items[index]
  }
  
  public var point: String {
    String(format: "%.1f", item.point ?? 0)
  }
  
  public var location: String {
    (item.subLocation ?? "") + "/" + (item.city ?? "")
  }
  
  public var image: StorageReference {
    item.imageReference?.first ?? Storage.storage().reference()
  }
  
  public var nextImage: StorageReference {
    item.imageReference?.first ?? Storage.storage().reference()
  }
  
  public var prevImage: StorageReference {
      item.imageReference?.first ?? Storage.storage().reference()
  }
  
  public func addVelocity(value: CGFloat) {
    velocityArray.append(value)
    
    if velocityArray.count > 10 {
      velocityArray.removeFirst()
    }
  }
  
}

