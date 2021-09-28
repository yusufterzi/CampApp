//
//  CampModel.swift
//  CampApp
//
//  Created by yusuf terzi on 23.09.2021.
//

import Foundation

final class CampModel: Codable {
  var name: String?
  var subLocation: String?
  var city: String?
  var desc: String?
  var images: [String]?
  var latitude: Double?
  var longitude: Double?
  var point: Double?
}
