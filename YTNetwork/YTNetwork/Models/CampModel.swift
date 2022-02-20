//
//  CampModel.swift
//  CampApp
//
//  Created by yusuf terzi on 23.09.2021.
//

import Foundation

public struct CampModel: Codable {
  public var name: String?
  public var subLocation: String?
  public var city: String?
  public var description: String?
  public var images: [String]?
  public var latitude: Double?
  public var longitude: Double?
  public var point: Double?
}
