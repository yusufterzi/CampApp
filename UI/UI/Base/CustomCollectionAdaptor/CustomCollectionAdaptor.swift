//
//  CustomCollectionAdaptor.swift
//  YTUI
//
//  Created by yusuf terzi on 6.10.2021.
//

import Carbon

class CustomCollectionViewAdapter: UICollectionViewFlowLayoutAdapter {
  var itemShowedAtIndex: ((Int) -> Void)?

  open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let pageWidth = scrollView.frame.size.width
    let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
    
    itemShowedAtIndex?(page)
  }
}
