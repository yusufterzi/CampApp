//
//  SegmentItemComponent.swift
//  YTUI
//
//  Created by yusuf terzi on 30.09.2021.
//

import Carbon

public final class SegmentItemComponent: IdentifiableComponent {
  
  var presenter: SegmentItemPresenterProtocol?
  
  public var id: String

  public init(id: String, presenter: SegmentItemPresenterProtocol) {
    self.presenter = presenter
    self.id = id
  }
  
  public func render(in content: SegmentItemView) {
    content.configureView(presenter: presenter) 
  }

  public func shouldContentUpdate(with next: SegmentItemComponent) -> Bool {
    return true
  }

  public func referenceSize(in bounds: CGRect) -> CGSize? {
    nil
  }
  
  public func renderContent() -> SegmentItemView {
    let view = SegmentItemView()
    return view
  }
}
