//
//  FavoriteController.swift
//  CampApp
//
//  Created by Nurullah Vural on 28.04.2022.
//

import Carbon
import XCoordinator
import YTUI
import Common

final class FavoriteController: BaseListController<FavoritePresenter> {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = ColorProvider.whiteTextColor.color
    CampDefaults.setup(with: PersistentDomain.test)
    CampDefaults.shared.storeFlag(with: .favouritesFirstOpen, value: true)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false)
    let favouritesFirstOpen : Bool = CampDefaults.shared.retrieve(with: .favouritesFirstOpen) ?? true
    favouritesFirstOpen ? CampDefaults.shared.storeFlag(with: .favouritesFirstOpen, value: false) : presenter?.loadUI()
        
  }
}
