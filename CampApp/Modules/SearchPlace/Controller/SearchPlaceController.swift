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

final class SearchPlaceController: BaseListController<SearchPlacePresenter> {
  
  lazy var searchController: UISearchController = {
      let sc = UISearchController(searchResultsController: nil)
      sc.obscuresBackgroundDuringPresentation = false
      sc.searchBar.delegate = self
      return sc
    }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = ColorProvider.whiteTextColor.color
    
    navigationItem.searchController = searchController
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false)
  }
  
}

extension SearchPlaceController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
  }
  

  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    
  }

}
