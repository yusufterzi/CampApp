//
//  MapViewController.swift
//  CampApp
//
//  Created by Nurullah Vural on 8.03.2022.
//

import UIKit
import Foundation
import MapKit
import CoreLocation


final class MapViewController: UIViewController {
    private var presenter: MapViewPresenter?
    
    private let map: MKMapView = {
        let map = MKMapView()
        return map
    } ()
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        view.addSubview(map)
        
        LocationManager.shared.getUserLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let strongSelf = self else {
                    return
                }
                strongSelf.addMapPin(with: location)
            }
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)

    }
    override func viewDidLayoutSubviews() {
        map.frame = view.bounds
    }
    public func setupPresenter(presenter: MapViewPresenter) {
        self.presenter = presenter
    }
    
    private func addMapPin(with location: CLLocation) {
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        map.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)), animated: true)
        map.addAnnotation(pin)
        
        LocationManager.shared.resolveLocationName(with: location) { [weak self] locationName in
            self?.title = locationName
        }
    }
    
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("Longitude: \(view.annotation?.coordinate.longitude)")
        print("Latitude: \(view.annotation?.coordinate.latitude)")

    }
}
