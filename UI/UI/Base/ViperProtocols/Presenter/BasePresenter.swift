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
  
}

public protocol BaseListPresenter {
  associatedtype T: Route
  associatedtype Z
  associatedtype W

  var view: W? { get }
  var interactor: Z? { get }
  var router: UnownedRouter<T> { get }
  
  func loadUI()
}
