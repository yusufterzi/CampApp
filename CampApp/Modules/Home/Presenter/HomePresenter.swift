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
import AttributedStringBuilder

protocol HomePresenterProtocol {
  func dataLoaded(areas: [CampModel])
}

final class HomePresenter: HomePresenterProtocol, BaseListPresenter {

  internal weak var view: BaseListView?
  internal var interactor: HomeInteractorProtocol?
  internal var router: UnownedRouter<HomeRoute>
  
  init(view: BaseListView, router: UnownedRouter<HomeRoute>) {
    self.view = view
    self.router = router
    self.interactor = HomeInteractor()
  }
  
  func loadUI() {
    view?.sendAction(.title(StringProvider.firstTabTitle))
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
      
      cells.append(headerView())
      cells.append(CellNode(component))
      cells.append(CellNode(component))
      cells.append(CellNode(component))
      cells.append(CellNode(component))
    }
    
    let section = Section(id: "", header: nil, cells: cells, footer: nil)
    
    view?.sendAction(.loadData([section]))
  }
  
  private func headerView() -> CellNode {
    
    let firstPartAttributes: [AttributedStringBuilder.Attribute] = [
      .font(FontProvider.bigHeaderRegular),
      .textColor(ColorProvider.blackTextColor),
    ]
    
    let firstPart: NSAttributedString = AttributedStringBuilder().text(StringProvider.campAreas, attributes: firstPartAttributes).attributedString
    
    let secondPartAttributes: [AttributedStringBuilder.Attribute] = [
      .font(FontProvider.bigHeaderBold),
      .textColor(ColorProvider.blackTextColor),
    ]
    
    let secondPart: NSAttributedString = AttributedStringBuilder().text(StringProvider.campAreasSecondPart, attributes: secondPartAttributes).attributedString
    
    let component = ViewHeaderComponent(id: "header",
                                        presenter: ViewHeaderPresenter(firstPart: firstPart, secondPart: secondPart))
    
    return CellNode(component)
  }
  
}
