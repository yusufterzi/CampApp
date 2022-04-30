//
//  FavoritePresenter.swift
//  CampApp
//
//  Created by Nurullah Vural on 28.04.2022.
//


import XCoordinator
import Carbon
import Common
import YTUI
import YTNetwork
import AttributedStringBuilder
import FirebaseStorage

protocol FavoritePresenterProtocol {
  
}

final class FavoritePresenter: FavoritePresenterProtocol, BaseListPresenter {
  
  internal weak var view: BaseListView?
  internal var interactor: FavoriteInteractorProtocol?
  internal var router: UnownedRouter<FavouriteRoute>
  
  private let storageRef = Storage.storage().reference()
  
  init(view: BaseListView, router: UnownedRouter<FavouriteRoute>) {
    self.view = view
    self.router = router
    self.interactor = FavoriteInteractor()
  }
  
  func loadUI() {
    view?.sendAction(.title(StringProvider.tabFavorite))
    interactor?.loadHandler = { [weak self] in
        self?.dataLoaded()
    }
    interactor?.emptyHandler = { [weak self] in
        //Fixme: Empty State 
        self?.emptySateLoad()
    }
    interactor?.loadData()

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
      }
      let component = CampComponent(id: camp.name ?? "",
                                    presenter: presenter)
      let cell = CellNode(component)
      cells.append(cell)
    }
    
    
    let section = Section(id: "", header: nil, cells: cells, footer: nil)
    
    view?.sendAction(.loadData([section]))
  }
  
  func emptySateLoad() {
    guard let interactor = interactor else { return }
    var cells: [CellNode] = []
    cells.append(headerView())
    
    let section = Section(id: "", header: nil, cells: cells, footer: nil)
    
    view?.sendAction(.loadData([section]))
  }
  
  
  private func headerView() -> CellNode {
    
    let firstPartAttributes: [AttributedStringBuilder.Attribute] = [
      .font(FontProvider.bigHeaderRegular),
      .textColor(ColorProvider.blackTextColor.color),
    ]
    
    let firstPart: NSAttributedString = AttributedStringBuilder().text(StringProvider.tabFavorite, attributes: firstPartAttributes).attributedString
    
    
    
    let component = ViewHeaderComponent(id: "header",
                                        presenter: ViewHeaderPresenter(firstPart: firstPart, secondPart: NSAttributedString()))
    
    return CellNode(component)
  }
  
  
  
  
}
