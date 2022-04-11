//
//  ButtonComponent.swift
//  YTUI
//
//  Created by Nurullah Vural on 4.03.2022.
//

import Carbon

public final class ButtonComponent: IdentifiableComponent {
    
    var presenter: ButtonPresenterProtocol?
    
    public var id: String
    
    public init(id: String, presenter: ButtonPresenterProtocol) {
        self.presenter = presenter
        self.id = id
    }
    
    public func render(in content: ButtonView) {
        content.presenter = presenter
        content.loadUI()
    }
    
    public func shouldContentUpdate(with next: ButtonComponent) -> Bool {
        return true
    }
    
    public func referenceSize(in bounds: CGRect) -> CGSize? {
        nil
    }
    
    public func renderContent() -> ButtonView {
        let button = ButtonView()
        return button
    }
}
