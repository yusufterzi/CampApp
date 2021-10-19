//
//  CampDetailComponent.swift
//  YTUI
//
//  Created by yusuf terzi on 3.10.2021.
//

import Carbon

public final class CampDetailComponent: IdentifiableComponent {
  
  var presenter: CampDetailComponentPresenterProtocol?
  public var id: String

  public init(id: String, presenter: CampDetailComponentPresenterProtocol) {
    self.presenter = presenter
    self.id = id
  }
  
  public func render(in content: CampDetailComponentView) {
    content.presenter = presenter
  }

  public func shouldContentUpdate(with next: CampDetailComponent) -> Bool {
    return true
  }

  public func referenceSize(in bounds: CGRect) -> CGSize? {
    nil
  }
  
  public func renderContent() -> CampDetailComponentView {
    let view = CampDetailComponentView()
    if let presenter = presenter {
      view.configureView(presenter: presenter)
    }
    return view
  }
}
