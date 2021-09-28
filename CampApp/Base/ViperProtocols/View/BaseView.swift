//
//  BaseView.swift
//  CampApp
//
//  Created by yusuf terzi on 23.09.2021.
//

import Carbon

protocol BaseListView {
  func viewUpdated(sections: [Section])
}

protocol BaseView: class {
  associatedtype Presenter
  
  var presenter: Presenter? { get set }
  
  func loadUI()
  
  func configureView(presenter: Presenter)
}
