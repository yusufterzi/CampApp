//
//  CampDetailDistanceComponent.swift
//  YTUI
//
//  Created by yusuf terzi on 6.10.2021.
//

import Carbon

public final class CampDetailDistanceComponent: IdentifiableComponent {
  
  var presenter: ImagePresenterProtocol?
  public var id: String

  public init(id: String, presenter: ImagePresenterProtocol) {
    self.presenter = presenter
    self.id = id
  }
  
  public func render(in content: ImageView) {
    content.presenter = presenter
    content.loadUI()
  }

  public func shouldContentUpdate(with next: CampDetailDistanceComponent) -> Bool {
    return true
  }

  public func referenceSize(in bounds: CGRect) -> CGSize? {
    nil
  }
  
  public func renderContent() -> ImageView {
    let view = ImageView()
    return view
  }
}
