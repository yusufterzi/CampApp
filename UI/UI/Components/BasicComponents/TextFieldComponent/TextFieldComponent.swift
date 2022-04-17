//
//  TextFieldComponent.swift
//  YTUI
//
//  Created by Nurullah Vural on 2.03.2022.
//

import Carbon

public final class TextFieldComponent: IdentifiableComponent {
    
    var presenter: TextFieldPresenterProtocol?
    
    public var id: String
    
    public init(id: String, presenter: TextFieldPresenterProtocol) {
        self.presenter = presenter
        self.id = id
    }
    
    public func render(in content: TextField) {
        content.presenter = presenter
        content.loadUI()
        
    }
    
    public func shouldContentUpdate(with next: TextFieldComponent) -> Bool {
        return true
    }
    
    public func referenceSize(in bounds: CGRect) -> CGSize? {
        nil
    }
    
    public func renderContent() -> TextField {
        let textField = TextField()
        return textField
    }
}
