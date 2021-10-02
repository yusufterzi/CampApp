//
//  YTPageStackViewPresenter.swift
//  YTUI
//
//  Created by yusuf terzi on 1.10.2021.
//

import Common

protocol YTPageStackViewPresenterProtocol {
  var itemCount: Int { get set }
  var selectedItemIndex: Int { get set }
  var indexChangeHandler: Handler<Int>? { get set }
}

final class YTPageStackViewPresenter: YTPageStackViewPresenterProtocol {
  var indexChangeHandler: Handler<Int>?
  var itemCount: Int
  var selectedItemIndex: Int = 0 {
    didSet {
      indexChangeHandler?(selectedItemIndex)
    }
  }
  
  init(itemCount: Int) {
    self.itemCount = itemCount
  }
  
}
