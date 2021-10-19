//
//  HomeController.swift
//  CampApp
//
//  Created by yusuf terzi on 23.09.2021.
//

import Carbon
import XCoordinator
import YTUI
import Common

final class HomeController: BaseListController<HomePresenter> {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = ColorProvider.whiteTextColor.color
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false)
  }
  
}
