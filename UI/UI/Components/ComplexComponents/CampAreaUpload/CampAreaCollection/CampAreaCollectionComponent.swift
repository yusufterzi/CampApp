//
//  CampAreaCollectionComponent.swift
//  YTUI
//
//  Created by Nurullah Vural on 4.03.2022.
//

import Carbon

public final class CampAreaCollectionComponent: IdentifiableComponent {
  
  var presenter: CampAreaCollectionPresenterProtocol
  public var id: String

  public init(id: String, presenter: CampAreaCollectionPresenterProtocol) {
    self.presenter = presenter
    self.id = id
  }
  
  public func render(in content: CampAreaCollectionView) {
    content.configureView(presenter: presenter)
  }

  public func shouldContentUpdate(with next: CampAreaCollectionComponent) -> Bool {
    return true
  }

  public func referenceSize(in bounds: CGRect) -> CGSize? {
    nil
  }
  
  public func renderContent() -> CampAreaCollectionView {
    let view = CampAreaCollectionView()
    view.configureView(presenter: presenter)
    return view
  }
}
