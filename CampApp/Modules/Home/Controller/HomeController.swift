//
//  HomeController.swift
//  CampApp
//
//  Created by yusuf terzi on 23.09.2021.
//

import Carbon
import XCoordinator
import YTUI

final class HomeController: BaseListController<HomePresenter> {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false)
  }
  
}
