//
//  ViewHeaderPresenter.swift
//  YTUI
//
//  Created by yusuf terzi on 29.09.2021.
//

import Foundation

public protocol ViewHeaderPresenterProtocol {
  var firstPart: NSAttributedString { get set }
  var secondPart: NSAttributedString { get set }
}

public final class ViewHeaderPresenter: ViewHeaderPresenterProtocol {
  public var firstPart: NSAttributedString
  public var secondPart: NSAttributedString

  public init(firstPart: NSAttributedString, secondPart: NSAttributedString) {
    self.firstPart = firstPart
    self.secondPart = secondPart
  }
}
