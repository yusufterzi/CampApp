//
//  TextRowComponent.swift
//  YTUI
//
//  Created by Nurullah Vural on 28.02.2022.
//

import Carbon

public final class TextRowComponent: IdentifiableComponent {
    
    var presenter: TextRowPresenterProtocol?
    
    public var id: String
    
    public init(id: String, presenter: TextRowPresenterProtocol) {
        self.presenter = presenter
        self.id = id
    }
    
    public func render(in content: TextRow) {
        
    }
    
    public func shouldContentUpdate(with next: TextRowComponent) -> Bool {
        return true
    }
    
    public func referenceSize(in bounds: CGRect) -> CGSize? {
        nil
    }
    
    public func renderContent() -> TextRow {
        let textRow = TextRow()
        if let presenter = presenter {
            textRow.configureView(presenter: presenter)
        }
        return textRow
    }
}
