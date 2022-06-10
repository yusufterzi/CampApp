//
//  CampDetailPresenter.swift
//  CampApp
//
//  Created by yusuf terzi on 4.10.2021.
//

import MapKit
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
  internal var router: UnownedRouter<CampDetailRoute>
  internal var item: CampComponentViewModel
  
  init(view: BaseListView, router: UnownedRouter<CampDetailRoute>, item: CampComponentViewModel) {
    self.view = view
    self.router = router
    self.interactor = CampDetailInteractor()
    self.item = item
  }
  
  func loadUI() {
    dataLoaded()
    
//    saveItemLocation()
    
  }
  
  private func saveItemLocation() {
    if let lat = item.latitude, let lng = item.longitude {
      FirebaseNetwork.shared?.geoFirestore.setLocation(
        location: CLLocation(latitude: lat,
                             longitude: lng),
        forDocumentWithID: item.id) { (error) in
          if let error = error {
              print("An error occured: \(error)")
          } else {
              print("Saved location successfully!")
          }
      }
    }
  }
  
  func dataLoaded() {
    var cells: [CellNode] = []

    let campDetailPresenter = CampDetailComponentPresenter(item: self.item)
    
    if let user = SessionHelper.shared.user {
      if user.favouriteCamps.contains(self.item.id) {
        campDetailPresenter.userFavorite = true
      }
    }
    campDetailPresenter.backButtonTapped = { [weak self] in
        self?.router.trigger(.back)
    }
    campDetailPresenter.editButtonTapped = { [weak self] in
      guard let item = self?.item else { return }
      let references = item.imageReference?.compactMap { $0.name }
      self?.router.trigger(.editCampArea(CampModel(name: item.name,
                                                   subLocation: item.subLocation,
                                                   city: item.city,
                                                   description: item.description,
                                                   images: references,
                                                   latitude: item.latitude,
                                                   longitude: item.longitude,
                                                   point: item.point,
                                                   address: item.address)))
    }
    campDetailPresenter.maximizeButtonTapped = { [weak self] references in
        self?.router.trigger(.imageSlider(references), with: TransitionOptions(animated: true))
    }
    campDetailPresenter.favoriteButtonHandler = { [weak self] favoriteType in
      favoriteType == FavoriteType.add ? self?.interactor?.addFavorite(campId: self?.item.id ?? "", completion: nil) : self?.interactor?.deleteFavorite(campId: self?.item.id ?? "", completion: nil)
    }
 
    
    let campComponent = CampDetailComponent(id: "", presenter: campDetailPresenter)
    
    cells.append(CellNode(campComponent))
    
    let section = Section(id: "", header: nil, cells: cells, footer: nil)
    
    view?.sendAction(.loadData([section]))
  }
}
