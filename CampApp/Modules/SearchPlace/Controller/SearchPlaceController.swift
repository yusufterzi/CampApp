//
//  SearchPlaceController.swift
//  CampApp
//
//  Created by yusuf terzi on 21.04.2022.
//

import Carbon
import XCoordinator
import YTUI
import Common
import GooglePlaces
import YTNetwork
import UIKit

final class SearchPlaceController: BaseListController<SearchPlacePresenter> {
  
  private enum AddressConstant {
    static let subLocation: String = "administrative_area_level_2"
    static let city: String = "administrative_area_level_1"

  }
  
  private var searchController: UISearchController?
  
  lazy private var resultsViewController = GMSAutocompleteResultsViewController()
  public var camp: CampModel = .init()
  public var place_id: String = ""
  public var campImages: [UIImage] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = ColorProvider.whiteTextColor.color
    
    resultsViewController.delegate = self
    
    searchController = UISearchController(searchResultsController: resultsViewController)
    
    resultsViewController.delegate = self
    
    searchController?.searchResultsUpdater = resultsViewController
    searchController?.searchBar.sizeToFit()
    navigationItem.searchController = searchController
    definesPresentationContext = true
    searchController?.hidesNavigationBarDuringPresentation = false
    
    
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
}

extension SearchPlaceController: GMSAutocompleteResultsViewControllerDelegate {
  func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                         didAutocompleteWith place: GMSPlace) {
    searchController?.isActive = false
    camp.name = place.name
    camp.longitude = place.coordinate.longitude
    camp.latitude = place.coordinate.latitude
    camp.address = place.formattedAddress
    camp.subLocation = place.addressComponents?.filter { $0.types.first == AddressConstant.subLocation }.first?.name
    camp.city = place.addressComponents?.filter { $0.types.first == AddressConstant.city}.first?.name
    
    let dispatchGroup = DispatchGroup()
    
    for photo in place.photos ?? [] {
      dispatchGroup.enter()
      GMSPlacesClient.shared().loadPlacePhoto(photo, callback: { (photo, error) -> Void in
        if let error = error {
          print("Error loading photo metadata: \(error.localizedDescription)")
          return
        }
        guard let image = photo else { return }
        self.campImages.append(image)
        dispatchGroup.leave()
      })
    }
    
    dispatchGroup.notify(queue: .main) {
      self.presenter?.router.trigger(.addCampArea(self.camp, self.campImages), with: TransitionOptions(animated: true))
    }
    
  }
  
  func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                         didFailAutocompleteWithError error: Error){
    // TODO: handle the error.
    print("Error: ", error.localizedDescription)
  }
  
}
