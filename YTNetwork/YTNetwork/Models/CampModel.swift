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
    
    public init(name: String? = nil, subLocation: String? = nil , city: String? = nil, description: String? = nil, images: [String]? = nil, latitude: Double? = nil, longitude: Double? = nil, point: Double? = nil) {
        
        self.name = name
        self.subLocation = subLocation
        self.city = city
        self.description = description
        self.images = images
        self.latitude = latitude
        self.longitude = longitude
        self.point = point
    }
}
