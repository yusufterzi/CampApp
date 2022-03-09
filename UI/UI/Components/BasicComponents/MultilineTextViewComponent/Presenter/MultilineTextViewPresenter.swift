//
//  MultilineTextViewPresenter.swift
//  YTUI
//
//  Created by Nurullah Vural on 3.03.2022.
//

import Foundation
import UIKit
import Common

public protocol MultilineTextViewPresenterProtocol {
    var headerTitle: String { get set }
    var headerFont: UIFont { get set }
    var headerColor: UIColor { get set }
    var headerEdgeInsets: UIEdgeInsets? { get set }
    var placeHolder: String { get set }
    var textEdited: Handler<String>? { get set }

}

public final class MultilineTextViewPresenter: MultilineTextViewPresenterProtocol {
    public var headerTitle: String
    public var headerFont: UIFont
    public var headerColor: UIColor
    public var headerEdgeInsets: UIEdgeInsets?
    public var placeHolder: String
    public var textEdited: Handler<String>?

    public init(headerTitle: String, headerFont: UIFont, headerColor: UIColor, headerEdgeInsets: UIEdgeInsets, placeHolder: String) {
        self.headerTitle = headerTitle
        self.headerFont = headerFont
        self.headerColor = headerColor
        self.headerEdgeInsets = headerEdgeInsets
        self.placeHolder = placeHolder
    }
}
