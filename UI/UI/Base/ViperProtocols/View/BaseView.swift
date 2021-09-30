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

public protocol BaseListView: AnyObject {
  func sendAction(_ action: ListViewActions)
}

public protocol BaseView: AnyObject {
  associatedtype Presenter
  
  func loadUI()
  func configureView(presenter: Presenter?)
}
