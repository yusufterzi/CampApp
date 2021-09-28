//
//  CampComponent.swift
//  CampApp
//
//  Created by yusuf terzi on 24.09.2021.
//

import Carbon

final class CampComponent: IdentifiableComponent {
  
  var presenter: CampComponentPresenter?
  var id: String

  init(id: String, presenter: CampComponentPresenter) {
    self.presenter = presenter
    self.id = id
  }
  
  func render(in content: CampComponentView) {
    content.presenter = presenter
    presenter?.view = content
    content.loadUI()
  }

  func shouldContentUpdate(with next: CampComponent) -> Bool {
    return true
  }

  func referenceSize(in bounds: CGRect) -> CGSize? {
    nil
  }
  
  func renderContent() -> CampComponentView {
    let view = CampComponentView()
    return view
  }
}
