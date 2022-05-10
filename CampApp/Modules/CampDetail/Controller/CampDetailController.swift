//
//  CampDetailController.swift
//  CampApp
//
//  Created by yusuf terzi on 4.10.2021.
//

import Common
import Carbon
import XCoordinator
import YTUI

final class CampDetailController: BaseListController<CampDetailPresenter> {
  
  override func viewDidLoad() {
    topSafeEnabled = false
    super.viewDidLoad()
    self.view.backgroundColor = ColorProvider.whiteTextColor.color
    self.disableScrolling()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false)
  }
  
}
