//
//  ViewHeaderComponent.swift
//  YTUI
//
//  Created by yusuf terzi on 29.09.2021.
//

import Carbon

public final class ViewHeaderComponent: IdentifiableComponent {
  
  var presenter: ViewHeaderPresenterProtocol?
  
  public var id: String

  public init(id: String, presenter: ViewHeaderPresenterProtocol) {
    self.presenter = presenter
    self.id = id
  }
  
  public func render(in content: ViewHeaderView) {
    content.presenter = presenter
  }

  public func shouldContentUpdate(with next: ViewHeaderComponent) -> Bool {
    return true
  }

  public func referenceSize(in bounds: CGRect) -> CGSize? {
    nil
  }
  
  public func renderContent() -> ViewHeaderView {
    let view = ViewHeaderView()
    view.configureView(presenter: presenter)
    return view
  }
}

