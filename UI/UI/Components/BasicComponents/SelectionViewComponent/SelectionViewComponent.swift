//
//  SelectionViewComponent.swift
//  YTUI
//
//  Created by Nurullah Vural on 10.05.2022.
//

import Foundation

import Carbon

public final class SelectionViewComponent: IdentifiableComponent {
    
    var presenter: SelectionViewPresenterProtocol?
    
    public var id: String
    
    public init(id: String, presenter: SelectionViewPresenterProtocol) {
        self.presenter = presenter
        self.id = id
    }
    
    public func render(in content: SelectionView) {
        content.presenter = presenter
        content.loadUI()
        
    }
    
    public func shouldContentUpdate(with next: SelectionViewComponent) -> Bool {
        return true
    }
    
    public func referenceSize(in bounds: CGRect) -> CGSize? {
        nil
    }
    
    public func renderContent() -> SelectionView {
      let selectionView = SelectionView()
      return selectionView
    }
}
