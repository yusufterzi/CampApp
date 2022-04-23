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
    camp.description = ""
    camp.address = place.formattedAddress
    camp.subLocation = place.addressComponents?.first?.name
    //camp.images = place.photos
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
      self?.presenter?.router.trigger(.addCampArea(self?.camp ?? CampModel()), with: TransitionOptions(animated: true))
    }
  }
  

  func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                         didFailAutocompleteWithError error: Error){
    // TODO: handle the error.
    print("Error: ", error.localizedDescription)
  }

}
