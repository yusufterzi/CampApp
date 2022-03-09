//
//  TextFieldPresenter.swift
//  YTUI
//
//  Created by Nurullah Vural on 2.03.2022.
//


import Foundation
import UIKit
import Common

public protocol TextFieldPresenterProtocol {
    var headerTitle: String { get set }
    var headerFont: UIFont { get set }
    var headerColor: UIColor { get set }
    var headerEdgeInsets: UIEdgeInsets? { get set }
    var placeHolder: String { get set }
    var image: UIImage? { get set }
    var isUserInteractionEnabled: Bool { get set }
    var onTap: VoidHandler? { get set }
    var textEdited: Handler<String>? { get set }
    
    
}

public final class TextFieldPresenter: TextFieldPresenterProtocol {
    public var headerTitle: String
    public var headerFont: UIFont
    public var headerColor: UIColor
    public var headerEdgeInsets: UIEdgeInsets?
    public var placeHolder: String
    public var image: UIImage?
    public var isUserInteractionEnabled: Bool
    public var onTap: VoidHandler?
    public var textEdited: Handler<String>?
    
    
    public init(headerTitle: String, headerFont: UIFont, headerColor: UIColor, headerEdgeInsets: UIEdgeInsets, placeHolder: String, image: UIImage? = nil, isUserInteractionEnabled: Bool = true) {
        self.headerTitle = headerTitle
        self.headerFont = headerFont
        self.headerColor = headerColor
        self.headerEdgeInsets = headerEdgeInsets
        self.placeHolder = placeHolder
        self.image = image
        self.isUserInteractionEnabled = isUserInteractionEnabled
    }
}
