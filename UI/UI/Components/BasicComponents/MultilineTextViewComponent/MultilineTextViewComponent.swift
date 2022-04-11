//
//  MultilineTextViewComponent.swift
//  YTUI
//
//  Created by Nurullah Vural on 3.03.2022.
//
import Carbon

public final class MultilineTextViewComponent: IdentifiableComponent {
    
    var presenter: MultilineTextViewPresenterProtocol?
    
    public var id: String
    
    public init(id: String, presenter: MultilineTextViewPresenterProtocol) {
        self.presenter = presenter
        self.id = id
    }
    
    public func render(in content: MultilineTextView) {
        content.presenter = presenter
        content.loadUI()
        
    }
    
    public func shouldContentUpdate(with next: MultilineTextViewComponent) -> Bool {
        return true
    }
    
    public func referenceSize(in bounds: CGRect) -> CGSize? {
        nil
    }
    
    public func renderContent() -> MultilineTextView {
        let textField = MultilineTextView()
        return textField
    }
}
