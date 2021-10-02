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
  
  private var segments: [HomeSegmentEnum] = [.all, .caravan, .tent, .bungalow]
  private var selectedSegment: HomeSegmentEnum = .all
  
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

    cells.append(headerView())
    cells.append(segmentSelectView())
    
    cells.append(carusellView(areas: areas))
    
    for area in areas {
      let component = CampComponent(id: area.name ?? "",
                                    presenter: CampComponentPresenter(item: area))
      cells.append(CellNode(component))
    }
    
    let section = Section(id: "", header: nil, cells: cells, footer: nil)
    
    view?.sendAction(.loadData([section]))
  }
  
  private func headerView() -> CellNode {
    
    let firstPartAttributes: [AttributedStringBuilder.Attribute] = [
      .font(FontProvider.bigHeaderRegular),
      .textColor(ColorProvider.blackTextColor.color),
    ]
    
    let firstPart: NSAttributedString = AttributedStringBuilder().text(StringProvider.campAreas, attributes: firstPartAttributes).attributedString
    
    let secondPartAttributes: [AttributedStringBuilder.Attribute] = [
      .font(FontProvider.bigHeaderBold),
      .textColor(ColorProvider.blackTextColor.color),
    ]
    
    let secondPart: NSAttributedString = AttributedStringBuilder().text(StringProvider.campAreasSecondPart, attributes: secondPartAttributes).attributedString
    
    let component = ViewHeaderComponent(id: "header",
                                        presenter: ViewHeaderPresenter(firstPart: firstPart, secondPart: secondPart))
    
    return CellNode(component)
  }
  
  private func segmentSelectView() -> CellNode {
    var items: [SegmentItemModel] = .init()
    for segment in segments {
      items.append(SegmentItemModel(identifier: segment.rawValue,
                       name: segment.title,
                       isSelected: segment == selectedSegment))
    }
    
    let component = SegmentSelectionComponent(id: "segment", presenter: SegmentSelectionPresenter(items: items))
    return CellNode(component)
  }
  
  private func carusellView(areas: [CampModel]) -> CellNode {
    
    var areas: [CampModel] = areas
    areas.append(areas.first!)
    areas.append(areas.first!)
    areas.append(areas.first!)
    areas.append(areas.first!)
    
    let presenter: YTCarouselPresenter = YTCarouselPresenter(items: areas)
    let component: YTCarouselComponent = YTCarouselComponent(id: "", presenter: presenter)
    
    return CellNode(component)

  }
  
}
