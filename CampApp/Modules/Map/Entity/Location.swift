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
    
    init(address: String, coordinate: CLLocationCoordinate2D?){
        self.address = address
        self.coordinate = coordinate
    }
}
