//
//  YTCarouselComponent.swift
//  YTUI
//
//  Created by yusuf terzi on 1.10.2021.
//

import Carbon

public final class YTCarouselComponent: IdentifiableComponent {
  
  var presenter: YTCarouselPresenterProtocol?
  
  public var id: String

  public init(id: String, presenter: YTCarouselPresenterProtocol) {
    self.presenter = presenter
    self.id = id
  }
  
  public func render(in content: YTCarouselView) {
    content.presenter = presenter
  }

  public func shouldContentUpdate(with next: YTCarouselComponent) -> Bool {
    return true
  }

  public func referenceSize(in bounds: CGRect) -> CGSize? {
    nil
  }
  
  public func renderContent() -> YTCarouselView {
    let view = YTCarouselView()
    view.configureView(presenter: presenter)
    return view
  }
}
