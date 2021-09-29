//
//  BaseView.swift
//  CampApp
//
//  Created by yusuf terzi on 23.09.2021.
//

import Carbon

public protocol BaseListView {
  func viewUpdated(sections: [Section])
  func setupTitle(title: String)
}

public protocol BaseView: class {
  associatedtype Presenter
  
  var presenter: Presenter? { get set }
  
  func loadUI()
  func configureView(presenter: Presenter)
}
