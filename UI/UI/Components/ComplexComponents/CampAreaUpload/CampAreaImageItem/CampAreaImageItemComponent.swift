//
//  CampAreaImageItemComponent.swift
//  YTUI
//
//  Created by Nurullah Vural on 4.03.2022.
//

import Carbon

public final class CampAreaImageItemComponent: IdentifiableComponent {
  
  var presenter: CampAreaImageItemPresenterProtocol?
  
  public var id: String

  public init(id: String, presenter: CampAreaImageItemPresenterProtocol) {
    self.presenter = presenter
    self.id = id
  }
  
  public func render(in content: CampAreaImageView) {
      content.presenter = presenter
      content.loadUI()
  }

  public func shouldContentUpdate(with next: CampAreaImageItemComponent) -> Bool {
    return true
  }

  public func referenceSize(in bounds: CGRect) -> CGSize? {
    nil
  }
  
  public func renderContent() -> CampAreaImageView {
    let view = CampAreaImageView()
    return view
  }
}
