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
import FirebaseStorage

protocol HomePresenterProtocol {
  
}

final class HomePresenter: HomePresenterProtocol, BaseListPresenter {

  internal weak var view: BaseListView?
  internal var interactor: HomeInteractorProtocol?
  internal var router: UnownedRouter<HomeRoute>
  
  private var segments: [HomeSegmentEnum] = [.all, .caravan, .tent, .bungalow]
  private var selectedSegment: HomeSegmentEnum = .all
  private let storageRef = Storage.storage().reference()

  init(view: BaseListView, router: UnownedRouter<HomeRoute>) {
    self.view = view
    self.router = router
    self.interactor = HomeInteractor()
  }
  
  func loadUI() {
    view?.sendAction(.title(StringProvider.firstTabTitle))
    interactor?.loadData()
    interactor?.loadHandler = { [weak self] in
      if (self?.interactor?.camps.count ?? 0) > 0 && (self?.interactor?.areas.count ?? 0) > 0 {
        self?.dataLoaded()
      }
    }
  }
  
  func dataLoaded() {
    guard let interactor = interactor else { return }
    var cells: [CellNode] = []

    cells.append(headerView())
    cells.append(segmentSelectView())
    
    cells.append(headerViewForCorausel())
    cells.append(carusellView(camps: interactor.camps))

    if let areaView = areasView() {
      cells.append(areaView)
    }
    
      let campComponentViews = interactor.camps.compactMap { item in
          return CampComponentViewModel(name: item.name,
                                       subLocation: item.subLocation,
                                       city: item.city,
                                       description: item.description,
                                       imageReference: item.images?.compactMap { image in return self.storageRef.child("images/\(image).jpg") },
                                       latitude: item.latitude,
                                       longitude: item.longitude,
                                       point: item.point,
                                       address: item.address,
                                       id: item.id)
      }
    for camp in campComponentViews {
      let presenter = CampComponentPresenter(item: camp)
      presenter.onTap = { [weak self] in
        self?.router.trigger(.campDetail(camp), with: TransitionOptions(animated: true))
      }
      let component = CampComponent(id: camp.name ?? "",
                                    presenter: presenter)
      let cell = CellNode(component)
      cells.append(cell)
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
  
  private func carusellView(camps: [CampModel]) -> CellNode {
      let carouselViewModel = camps.compactMap { item in
          return CampCarouselViewModel(name: item.name,
                                       subLocation: item.subLocation,
                                       city: item.city,
                                       description: item.description,
                                       imageReference: item.images?.compactMap { image in return self.storageRef.child("images/\(image).jpg") },
                                       latitude: item.latitude,
                                       longitude: item.longitude,
                                       point: item.point,
                                       address: item.address,
                                       id: item.id)
      }
    
    let presenter: YTCarouselPresenter = YTCarouselPresenter(items: carouselViewModel)
    let component: YTCarouselComponent = YTCarouselComponent(id: "", presenter: presenter)
    
    return CellNode(component)

  }
  
  private func headerViewForCorausel() -> CellNode {
    let label = LabelComponent(id: "header",
                               presenter: LabelPresenter(
                                font: FontProvider.regular19,
                                textColor: ColorProvider.semiDarkTextColor.color,
                                text: StringProvider.nearestAreas,
                                insets: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)))
    return CellNode(label)
  }
  
  private func areasView() -> CellNode? {
    guard let interactor = interactor else {
      return nil
    }

    let component = CampAreaComponent(id: "campArea",
                                      presenter: CampAreaComponentPresenter(items: interactor.areas))
    return CellNode(component)
  }
  
}
