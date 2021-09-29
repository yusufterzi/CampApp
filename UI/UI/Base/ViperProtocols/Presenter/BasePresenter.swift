//
//  BasePresenter.swift
//  CampApp
//
//  Created by yusuf terzi on 23.09.2021.
//

import Foundation
import XCoordinator
import Carbon

public protocol BaseComponentPresenter {
  associatedtype BaseViewType
  var view: BaseViewType? { get set }
  var interactor: BaseInteractor? { get set }
}

public protocol BaseListPresenter {
  associatedtype T: Route
  associatedtype Z: BaseInteractor
  associatedtype W: BaseListView

  var view: W { get }
  var interactor: Z? { get }
  var router: UnownedRouter<T> { get }
  
  func loadUI()
}
