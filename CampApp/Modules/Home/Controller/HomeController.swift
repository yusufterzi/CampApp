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
    
    if let needOpenForMe: Bool = CampDefaults.shared.retrieve(with: .needOpenForMe), needOpenForMe {
      CampDefaults.shared.store(with: .needOpenForMe, value: false)
      presenter?.needOpenForMe()
    }
    
    GeneralUIHelper.shared.tabbarHeight = tabBarController?.tabBar.frame.height ?? 49.0
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false)
    if let reloadHomeTab : Bool = CampDefaults.shared.retrieve(with: .reloadHomeTab), reloadHomeTab {
      CampDefaults.shared.storeFlag(with: .reloadHomeTab, value: false)
      presenter?.loadUI()
    }
  }
  
}
