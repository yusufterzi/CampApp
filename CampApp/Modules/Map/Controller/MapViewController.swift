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
import Common
import XCoordinator
import SwiftUI
import YTNetwork

final class MapViewController: UIViewController, FloatingPanelControllerDelegate {
    
    private var presenter: MapViewPresenter?
    private let panel = FloatingPanelController()
    private var locationName: String?
    private let trackMeButton: UIButton = {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 24)
        button.frame = CGRect(x: 5, y: 5, width: 35, height: 35)
        button.setImage(UIImage(systemName: "location.fill", withConfiguration: configuration) , for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(trackMeButtonClicked), for: .touchUpInside)
        return button
    }()
    public var comletionHandler: Handler<Location>?
    public var selectedLocation: Location = {
        var location = Location(address: "" , coordinate: nil, city: "")
        return location
    }()
    private let map: MKMapView = {
        let map = MKMapView()
        return map
    } ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneClicked))
        setupView()
        setupConstraints()
        setupFloatingPanel()
        prepareMap()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.map.frame = view.bounds
    }
    public func setupPresenter(presenter: MapViewPresenter) {
        self.presenter = presenter
    }
    
    private func setupFloatingPanel() {
        let searchVC = SearchViewController()
        searchVC.delegate = self
        searchVC.keyboardWillShowHandler = { [weak self] in
            self?.panel.move(to: .full, animated: true)
        }
        searchVC.keyboardWillHideHandler = { [weak self] in
            self?.panel.move(to: .half, animated: true)
        }
        panel.set(contentViewController: searchVC)
        panel.delegate = self
        panel.layout = CustomFloatingPanelLayout()
        panel.addPanel(toParent: self)
    }
    private func prepareMap() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(longPressed))
        map.addGestureRecognizer(tapGestureRecognizer)
        LocationManager.shared.getUserLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let strongSelf = self else {
                    return
                }
                strongSelf.getLocationInfo(clLocation: location)
                strongSelf.map.setUserTrackingMode( .followWithHeading, animated: true)
            }
        }
    }
    
    private func getLocationInfo(clLocation: CLLocation){
        LocationManager.shared.resolveLocationName(with: clLocation) { location in
            self.selectedLocation = location ?? Location(address: "", coordinate: nil, city: "")
        }
    }
    
    private func setupView(){
        view.addSubview(map)
        map.addSubview(trackMeButton)
    }
    private func setupConstraints() {
        trackMeButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview().offset(8)
            $0.height.equalTo(44)
            $0.width.equalTo(44)
        }
    }
    @objc private func trackMeButtonClicked() {
        map.setUserTrackingMode( .follow, animated: true)
    }
    @objc func doneClicked() {
        self.presenter?.router.trigger(.back, with: TransitionOptions(animated: true))
        self.comletionHandler?(selectedLocation)
    }
    
    @objc func longPressed(sender: UILongPressGestureRecognizer) {
        let point = sender.location(in: self.map)
        let coordinate = self.map.convert(point, toCoordinateFrom: self.map)
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        map.removeAnnotations(map.annotations)
        map.addAnnotation(pin)
        map.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)), animated: true)
        panel.move(to: .tip, animated: true)
        
        LocationManager.shared.resolveLocationName(with: location) { [weak self] location in
            self?.selectedLocation = location ?? Location(address: "", coordinate: nil, city: "")
        }
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
        map.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)), animated: true)
        
        let clLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        LocationManager.shared.resolveLocationName(with: clLocation) { [weak self] location in
            self?.selectedLocation = location ?? Location(address: "", coordinate: nil, city: "")
        }
    }
}


