//
//  CampAreaComponent.swift
//  YTUI
//
//  Created by yusuf terzi on 2.10.2021.
//

import Carbon

public final class CampAreaComponent: IdentifiableComponent {
  
  var presenter: CampAreaComponentPresenterProtocol
  public var id: String

  public init(id: String, presenter: CampAreaComponentPresenterProtocol) {
    self.presenter = presenter
    self.id = id
  }
  
  public func render(in content: CampAreaComponentView) {
    content.configureView(presenter: presenter)
  }

  public func shouldContentUpdate(with next: CampAreaComponent) -> Bool {
    return true
  }

  public func referenceSize(in bounds: CGRect) -> CGSize? {
    nil
  }
  
  public func renderContent() -> CampAreaComponentView {
    let view = CampAreaComponentView()
    return view
  }
}
