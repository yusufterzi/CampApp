//
//  LabelComponent.swift
//  YTUI
//
//  Created by yusuf terzi on 2.10.2021.
//

import Carbon

public final class LabelComponent: IdentifiableComponent {
  
  var presenter: LabelPresenterProtocol?
  
  public var id: String

  public init(id: String, presenter: LabelPresenterProtocol) {
    self.presenter = presenter
    self.id = id
  }
  
  public func render(in content: Label) {
    
  }

  public func shouldContentUpdate(with next: LabelComponent) -> Bool {
    return true
  }

  public func referenceSize(in bounds: CGRect) -> CGSize? {
    nil
  }
  
  public func renderContent() -> Label {
    let label = Label()
    label.text = presenter?.text
    label.textColor = presenter?.textColor
    label.font = presenter?.font
    label.edgeInsets = presenter?.insets ?? UIEdgeInsets.zero
    return label
  }
}
