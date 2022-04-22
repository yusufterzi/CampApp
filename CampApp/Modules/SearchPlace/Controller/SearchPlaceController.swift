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

final class SearchPlaceController: BaseListController<SearchPlacePresenter> {
  
  private var searchController: UISearchController?
  
  lazy private var resultsViewController = GMSAutocompleteResultsViewController()

  
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
    print("Place name: \(place.name)")
    print("Place address: \(place.formattedAddress)")
    print("Place nurullah özel istek: \(place.coordinate)")
    print("Place attributions: \(place.attributions)")
    print("Place id: \(place.placeID)")
    print("Place photo count: \(place.photos?.count ?? 0)")
    
  }

  func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                         didFailAutocompleteWithError error: Error){
    // TODO: handle the error.
    print("Error: ", error.localizedDescription)
  }

}
