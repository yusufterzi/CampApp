//
//  CampAreasForMeController.swift
//  CampApp
//
//  Created by yusuf terzi on 27/04/2022.
//

import Carbon
import XCoordinator
import YTUI
import Common

final class CampAreasForMeController: BaseListController<CampAreasForMePresenter> {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = ColorProvider.whiteTextColor.color
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false)
  }
  
}
