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

final class SearchPlaceController: BaseListController<SearchPlacePresenter> {
  
  private var searchController: UISearchController?
  
  lazy private var resultsViewController = GMSAutocompleteResultsViewController()
  public var camp: CampModel = .init()
  public var googleClient: GoogleClient = .init()
  public var place_id: String = ""
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
    camp.subLocation = place.addressComponents?.first?.name
    self.place_id = place.placeID ?? ""
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
      self?.googleClient.getGooglePlacesDetailsData(place_id: self?.place_id ?? ""){ (response) in
        if let response = response {
          print("Passed response here:", response)
          
        }
        
      }
    }
  }
  
  func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                         didFailAutocompleteWithError error: Error){
    // TODO: handle the error.
    print("Error: ", error.localizedDescription)
  }
  
}
