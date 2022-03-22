//
//  Location.swift
//  CampApp
//
//  Created by Nurullah Vural on 10.03.2022

import Foundation
import CoreLocation

public class Location {
    var address: String
    var coordinate: CLLocationCoordinate2D?
    var city: String
    
    init(address: String, coordinate: CLLocationCoordinate2D?, city: String){
        self.address = address
        self.coordinate = coordinate
        self.city = city
    }
}
