//
//  SearchPlacePresenter.swift
//  CampApp
//
//  Created by yusuf terzi on 21.04.2022.
//

import XCoordinator
import Carbon
import Common
import YTUI
import YTNetwork
import AttributedStringBuilder
import FirebaseStorage

protocol SearchPlacePresenterProtocol {
  
}

final class SearchPlacePresenter: SearchPlacePresenterProtocol, BaseListPresenter {

  weak var view: BaseListView?
  var interactor: SearchPlaceInteractorProtocol?
  var router: UnownedRouter<SearchPlaceRoute>
  

  init(view: BaseListView, router: UnownedRouter<SearchPlaceRoute>) {
    self.view = view
    self.router = router
    self.interactor = SearchPlaceInteractor()
  }
  
  func loadUI() {
    view?.sendAction(.title(StringProvider.firstTabTitle))
    interactor?.loadData()
    interactor?.loadHandler = { [weak self] in
     
    }
  }
  
  func dataLoaded() {
    guard let interactor = interactor else { return }
    var cells: [CellNode] = []

    let section = Section(id: "", header: nil, cells: cells, footer: nil)
    
    view?.sendAction(.loadData([section]))
  }
  
}
