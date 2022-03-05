//
//  ButtonPresenter.swift
//  YTUI
//
//  Created by Nurullah Vural on 4.03.2022.
//
import Foundation
import Common
import UIKit

public protocol ButtonPresenterProtocol {
    var text: String { get set }
    var textColor: UIColor { get set }
    var textFont: UIFont { get set }
    var backgroundColor: UIColor { get set }
    var tapped: VoidHandler? { get set }

    
}

public final class ButtonPresenter: ButtonPresenterProtocol {
    public var textFont: UIFont
    public var textColor: UIColor
    public var text: String
    public var backgroundColor: UIColor
    public var tapped: VoidHandler?
    
    public init(textFont: UIFont, textColor: UIColor, text: String, backgroundColor: UIColor) {
        self.textFont = textFont
        self.textColor = textColor
        self.text = text
        self.backgroundColor = backgroundColor
    }
}
