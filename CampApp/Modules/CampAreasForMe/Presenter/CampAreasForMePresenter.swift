//
//  CampAreasForMePresenter.swift
//  CampApp
//
//  Created by yusuf terzi on 27/04/2022.
//

import XCoordinator
import Carbon
import Common
import YTUI
import YTNetwork
import AttributedStringBuilder
import FirebaseStorage

protocol CampAreasForMePresenterProtocol {
  
}

final class CampAreasForMePresenter: CampAreasForMePresenterProtocol, BaseListPresenter {
  
  internal weak var view: BaseListView?
  internal var interactor: CampAreasForMeInteractorProtocol?
  internal var router: UnownedRouter<HomeRoute>
  
  private let storageRef = Storage.storage().reference()
  
  init(view: BaseListView, router: UnownedRouter<HomeRoute>) {
    self.view = view
    self.router = router
    self.interactor = CampAreasForMeInteractor()
  }
  
  func loadUI() {
    view?.sendAction(.title(StringProvider.firstTabTitle))
    interactor?.getItems()
    interactor?.loadHandler = { [weak self] in
      if (self?.interactor?.camps.count ?? 0) > 0 {
        self?.dataLoaded()
      }
    }
  }
  
  func dataLoaded() {
    guard let interactor = interactor else { return }
    var cells: [CellNode] = []
    
    cells.append(headerView())
    
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
        self?.router.trigger(.dismiss, with: TransitionOptions(animated: true))

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
      .font(FontProvider.onboardingBigRegular),
      .textColor(ColorProvider.blackTextColor.color),
    ]
    
    let firstPart: NSAttributedString = AttributedStringBuilder().text(StringProvider.campAreasForYou, attributes: firstPartAttributes).attributedString
    
    let secondPartAttributes: [AttributedStringBuilder.Attribute] = [
      .font(FontProvider.onboardingBigBold),
      .textColor(ColorProvider.onboardingRedColor.color),
    ]
    
    let secondPart: NSAttributedString = AttributedStringBuilder().text(StringProvider.suggestions, attributes: secondPartAttributes).attributedString
    
    let component = ViewHeaderComponent(id: "header",
                                        presenter: ViewHeaderPresenter(firstPart: firstPart, secondPart: secondPart))
    
    return CellNode(component)
  }
  
}

