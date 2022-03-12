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
    
    public func findLocation(with query: String, completion: @escaping Handler<[Location]>) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(query) { places, error in
            guard let places = places, error == nil else {
                completion([])
                return
            }
            
            let models: [Location] = places.compactMap({ places in
                var name = ""
                
                if let locationName = places.name {
                    name += locationName
                }
                
                if let adminRegion = places.administrativeArea {
                    name += ", \(adminRegion)"
                }
                
                if let locality = places.locality {
                    name += ", \(locality)"
                }
                
                if let country = places.country {
                    name += ", \(country)"
                }
                
                let result = Location(address: name, coordinate: places.location?.coordinate)
                return result
            })
            
            completion(models)
            
        }

    }
    
    public func resolveLocationName(with location: CLLocation, completion: @escaping Handler<Location?>) {
        
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
            completion(Location(address: name, coordinate: location.coordinate))
        }
        
    }
    
}
