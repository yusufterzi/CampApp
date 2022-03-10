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
import FloatingPanel

final class MapViewController: UIViewController {

    private var presenter: MapViewPresenter?
    let panel = FloatingPanelController()
    private var locationName: String?
    
    private let map: MKMapView = {
        let map = MKMapView()
        return map
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        view.addSubview(map)
        
        let searchVC = SearchViewController()
        searchVC.delegate = self
        searchVC.keyboardWillShowHandler = { [weak self] in
            self?.panel.move(to: .full, animated: true)
        }
        searchVC.keyboardWillHideHandler = { [weak self] in
            self?.panel.move(to: .half, animated: true)
        }
        panel.set(contentViewController: searchVC)
        panel.addPanel(toParent: self)
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(longPressed))
        self.map.addGestureRecognizer(tapGestureRecognizer)
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
        self.map.frame = view.bounds
    }
    public func setupPresenter(presenter: MapViewPresenter) {
        self.presenter = presenter
    }
    private func addMapPin(with location: CLLocation) {
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        pin.title = "Konumunuz"
        self.map.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)), animated: true)
        self.map.addAnnotation(pin)
        
        LocationManager.shared.resolveLocationName(with: location) { [weak self] locationName in
            self?.title = locationName
        }
        
    }
    @objc func longPressed(sender: UILongPressGestureRecognizer) {
        let point = sender.location(in: self.map)
        let coordinate = self.map.convert(point, toCoordinateFrom: self.map)
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        self.map.removeAnnotations(self.map.annotations)
        self.map.addAnnotation(pin)
        self.panel.move(to: .tip, animated: true)
        
        LocationManager.shared.resolveLocationName(with: location) { [weak self] locationName in
            self?.title = locationName
        }
    }
    
}
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.title != "Konumunuz" {
            let annotationView = mapView.view(for: annotation) as? MKPinAnnotationView ?? MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            annotationView.pinTintColor = UIColor.red
            annotationView.animatesDrop = true
            annotationView.canShowCallout = true
            return annotationView
        }
        return nil
        
    }
        
}
extension MapViewController: SearchViewControllerDelegate {
    
    func searchViewController(_ vc: SearchViewController, didUserSearchWith location: Location) {
        guard let coordinate =  location.coordinate else {
            return
        }
        panel.move(to: .tip, animated: true)
        map.removeAnnotations(map.annotations)
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        map.addAnnotation(pin)
        self.map.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)), animated: true)
        self.title = location.title
        
    }
}
