//
//  CampComponent.swift
//  CampApp
//
//  Created by yusuf terzi on 24.09.2021.
//

import Carbon

public final class CampComponent: IdentifiableComponent {
  
  var presenter: CampComponentPresenter?
  public var id: String

  public init(id: String, presenter: CampComponentPresenter) {
    self.presenter = presenter
    self.id = id
  }
  
  public func render(in content: CampComponentView) {
    content.presenter = presenter
    presenter?.view = content
    content.loadUI()
  }

  public func shouldContentUpdate(with next: CampComponent) -> Bool {
    return true
  }

  public func referenceSize(in bounds: CGRect) -> CGSize? {
    nil
  }
  
  public func renderContent() -> CampComponentView {
    let view = CampComponentView()
    return view
  }
}
