//
//  HomeController.swift
//  CampApp
//
//  Created by yusuf terzi on 23.09.2021.
//

import Carbon

final class HomeController: BaseListController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    renderer.render([])
  }
}

extension HomeController: BaseListView {
  
  func viewUpdated(sections: [Section]) {
    renderer.render(sections)
  }
  
}
