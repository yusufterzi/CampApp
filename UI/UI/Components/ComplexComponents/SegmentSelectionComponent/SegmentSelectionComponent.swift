//
//  SegmentSelectionComponent.swift
//  YTUI
//
//  Created by yusuf terzi on 29.09.2021.
//

import Carbon

public final class SegmentSelectionComponent: IdentifiableComponent {
  
  var presenter: SegmentSelectionPresenterProtocol?
  
  public var id: String

  public init(id: String, presenter: SegmentSelectionPresenterProtocol) {
    self.presenter = presenter
    self.id = id
  }
  
  public func render(in content: SegmentSelectionView) {
    content.presenter = presenter
  }

  public func shouldContentUpdate(with next: SegmentSelectionComponent) -> Bool {
    return true
  }

  public func referenceSize(in bounds: CGRect) -> CGSize? {
    nil
  }
  
  public func renderContent() -> SegmentSelectionView {
    let view = SegmentSelectionView()
    view.configureView(presenter: presenter)
    return view
  }
}
