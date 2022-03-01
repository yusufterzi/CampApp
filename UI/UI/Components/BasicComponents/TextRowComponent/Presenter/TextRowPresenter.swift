//
//  TextRowPresenter.swift
//  YTUI
//
//  Created by Nurullah Vural on 28.02.2022.
//

import UIKit

public protocol TextRowPresenterProtocol {
    var text: String { get set }
    var font: UIFont { get set }
    var color: UIColor { get set }
    var image: UIImage? { get set }
}
public final class TextRowPresenter: TextRowPresenterProtocol {
    public var text: String
    public var font: UIFont
    public var color: UIColor
    public var image: UIImage?
    
    public init(text: String, color: UIColor, font: UIFont, image: UIImage? = nil) {
        self.text = text
        self.font = font
        self.color = color
        self.image = image
    }
}
