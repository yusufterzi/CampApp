//
//  BaseView.swift
//  CampApp
//
//  Created by yusuf terzi on 23.09.2021.
//

import Carbon

public enum ListViewActions {
  case title(String)
  case loader(Bool)
  case loadData([Section])
  case emptyScreen
}

public protocol BaseListView {
  func sendAction(_ action: ListViewActions)
  func setupTitle(title: String)
}

public protocol BaseView {
  associatedtype Presenter
  
  var presenter: Presenter? { get set }
  
  func loadUI()
  func configureView(presenter: Presenter)
}
