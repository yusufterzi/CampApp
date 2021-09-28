//
//  BasePresenter.swift
//  CampApp
//
//  Created by yusuf terzi on 23.09.2021.
//

import Foundation
import XCoordinator

protocol BaseComponentPresenter {
  associatedtype BaseViewType
  var view: BaseViewType? { get set }
  var interactor: BaseInteractor? { get set }
}

protocol BaseListPresenter {
  associatedtype T: Route
  
  var view: BaseListView { get set }
  var interactor: BaseInteractor { get set }
  var router: UnownedRouter<T> { get set }
}
