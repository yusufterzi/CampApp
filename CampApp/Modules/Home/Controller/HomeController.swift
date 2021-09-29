//
//  HomeController.swift
//  CampApp
//
//  Created by yusuf terzi on 23.09.2021.
//

import Carbon
import XCoordinator

final class HomeController: BaseListController<HomePresenter> {
    
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
}

extension HomeController: BaseListView {
  
  func viewUpdated(sections: [Section]) {
    renderer.render(sections)
  }
  
}
