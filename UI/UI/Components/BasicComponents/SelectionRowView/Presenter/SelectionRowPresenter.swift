//
//  SelectionRowPresenter.swift
//  YTUI
//
//  Created by Nurullah Vural on 12.05.2022.
//

import UIKit
import Common

public final class SelectionRowPresenter {

  public var item: SelectionItemProtocol
  public var isSelected: Bool
  public var onTap: Handler<SelectionRowPresenter>?

  public init(item: SelectionItemProtocol, isSelected: Bool) {
    self.item = item
    self.isSelected = isSelected
  }
}
