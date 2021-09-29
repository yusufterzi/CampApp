//
//  HomePresenter.swift
//  CampApp
//
//  Created by yusuf terzi on 28.09.2021.
//

import XCoordinator
import Carbon
import Common
import YTUI
import YTNetwork

protocol HomePresenterProtocol {
  func dataLoaded(areas: [CampModel])
}

final class HomePresenter: HomePresenterProtocol, BaseListPresenter {

  internal let view: HomeController
  internal let interactor: HomeInteractor?
  internal let router: UnownedRouter<HomeRoute>
  
  init(view: HomeController, router: UnownedRouter<HomeRoute>) {
    self.view = view
    self.router = router
    self.interactor = HomeInteractor()
  }
  
  func loadUI() {
    view.setupTitle(title: StringProvider.firstTabTitle)
    interactor?.getCampAreas()
    interactor?.campAreasHandler = { [weak self] areas in
      self?.dataLoaded(areas: areas)
    }
  }
  
  func dataLoaded(areas: [CampModel]) {
    var cells: [CellNode] = []

    for area in areas {
      let component = CampComponent(id: area.name ?? "",
                                    presenter: CampComponentPresenter(item: area))
      cells.append(CellNode(component))
      cells.append(CellNode(component))
      cells.append(CellNode(component))
      cells.append(CellNode(component))
    }
    
    let section = Section(id: "", header: nil, cells: cells, footer: nil)
    
    view.viewUpdated(sections: [section])
  }
  
}
