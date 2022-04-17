//
//  CampDetailPresenter.swift
//  CampApp
//
//  Created by yusuf terzi on 4.10.2021.
//

import Foundation

import XCoordinator
import Carbon
import Common
import YTUI
import YTNetwork
import AttributedStringBuilder

protocol CampDetailPresenterProtocol {
  
}

final class CampDetailPresenter: CampDetailPresenterProtocol, BaseListPresenter {

  internal weak var view: BaseListView?
  internal var interactor: CampDetailInteractorProtocol?
  internal var router: UnownedRouter<HomeRoute>
  internal var item: CampComponentViewModel
  
  init(view: BaseListView, router: UnownedRouter<HomeRoute>, item: CampComponentViewModel) {
    self.view = view
    self.router = router
    self.interactor = CampDetailInteractor()
    self.item = item
  }
  
  func loadUI() {
    dataLoaded()
  }
  
  func dataLoaded() {
    var cells: [CellNode] = []

    let campDetailPresenter = CampDetailComponentPresenter(item: self.item)
    campDetailPresenter.backButtonTapped = { [weak self] in
        self?.router.trigger(.back)
    }
    campDetailPresenter.maximizeButtonTapped = { [weak self] references in
        self?.router.trigger(.imageSlider(references), with: TransitionOptions(animated: true))
    }
    let campComponent = CampDetailComponent(id: "", presenter: campDetailPresenter)
    
    cells.append(CellNode(campComponent))
    
    let section = Section(id: "", header: nil, cells: cells, footer: nil)
    
    view?.sendAction(.loadData([section]))
  }
}
