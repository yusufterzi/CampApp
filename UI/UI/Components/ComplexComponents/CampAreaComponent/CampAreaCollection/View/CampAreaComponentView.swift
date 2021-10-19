//
//  CampAreaComponentView.swift
//  YTUI
//
//  Created by yusuf terzi on 2.10.2021.
//

import Foundation
import UIKit
import SDWebImage
import Common
import Carbon

public protocol CampAreaComponentViewProtocol {
  
}

public final class CampAreaComponentView: UIView, CampAreaComponentViewProtocol {
  
  private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
    $0.isScrollEnabled = true
    $0.alwaysBounceHorizontal = true
    $0.showsVerticalScrollIndicator = false
    $0.showsHorizontalScrollIndicator = false
    ($0.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
    $0.backgroundColor = .clear
  }
  
  let renderer = Renderer(
      adapter: UICollectionViewFlowLayoutAdapter(),
      updater: UICollectionViewUpdater()
  )
  
  public var presenter: CampAreaComponentPresenterProtocol?
 
  public init() {
    super.init(frame: .zero)
    initialize()

  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func configureView(presenter: CampAreaComponentPresenterProtocol) {
    self.presenter = presenter
    
    layoutIfNeeded()
    
    (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize = CGSize(width: 210, height: 160)

    renderer.target = collectionView
    renderer.render(presenter.sections)

  }
  
}

extension CampAreaComponentView {
  func initialize() {
    setupViews()
    setupConstraints()
  }
  
  func setupViews() {
    addSubview(collectionView)

  }
  
  func setupConstraints() {
    collectionView.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(16)
      $0.top.equalToSuperview().offset(8)
      $0.height.equalTo(180)
      $0.bottom.equalToSuperview().offset(-8)
      $0.trailing.equalToSuperview().offset(-16)
    }
  }
}
