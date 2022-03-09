//
//  LocationManager.swift
//  CampApp
//
//  Created by Nurullah Vural on 8.03.2022.
//

import Foundation
import CoreLocation
import Common

final class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    private let manager = CLLocationManager()
    private var completion: Handler<CLLocation>?
    
    public func getUserLocation(completion: @escaping Handler<CLLocation>) {
        self.completion = completion
        manager.requestAlwaysAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
   
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        completion?(location)
        manager.stopUpdatingLocation()
        
    }
    
    public func resolveLocationName(with location: CLLocation, completion: @escaping Handler<String?>) {
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location, preferredLocale: .current) { placeMarks, error in
            
            guard let place = placeMarks?.first, error == nil else {
                completion(nil)
                return
            }
            print (place)
            var name = ""
            if let locality = place.locality {
                name += locality
            }
            if let adminRegion = place.administrativeArea {
                name  += ", \(adminRegion)"
            }
            completion(name)
        }
        
    }
    
}
