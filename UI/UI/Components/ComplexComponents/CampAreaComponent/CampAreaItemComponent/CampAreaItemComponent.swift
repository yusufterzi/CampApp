//
//  CampAreaItemComponent.swift
//  YTUI
//
//  Created by yusuf terzi on 2.10.2021.
//

import Carbon

public final class CampAreaItemComponent: IdentifiableComponent {
  
  var presenter: CampAreaItemPresenterProtocol?
  
  public var id: String

  public init(id: String, presenter: CampAreaItemPresenterProtocol) {
    self.presenter = presenter
    self.id = id
  }
  
  public func render(in content: CampAreaItemView) {
    content.presenter = presenter
  }

  public func shouldContentUpdate(with next: CampAreaItemComponent) -> Bool {
    return true
  }

  public func referenceSize(in bounds: CGRect) -> CGSize? {
    nil
  }
  
  public func renderContent() -> CampAreaItemView {
    let view = CampAreaItemView()
    view.configureView(presenter: presenter)
    return view
  }
}
