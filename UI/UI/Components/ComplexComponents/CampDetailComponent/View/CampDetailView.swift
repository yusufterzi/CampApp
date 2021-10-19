//
//  CampDetailView.swift
//  YTUI
//
//  Created by yusuf terzi on 3.10.2021.
//


import Foundation
import UIKit
import SDWebImage
import Common
import Carbon

public protocol CampDetailComponentViewProtocol {
  
}

public final class CampDetailComponentView: UIView, CampDetailComponentViewProtocol {
  
  public var presenter: CampDetailComponentPresenterProtocol?
  
  private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
    $0.isScrollEnabled = true
    $0.alwaysBounceHorizontal = true
    $0.showsVerticalScrollIndicator = false
    $0.showsHorizontalScrollIndicator = false
    $0.isPagingEnabled = true
    ($0.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
    ($0.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing = 0
    ($0.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing = 0
    ($0.collectionViewLayout as? UICollectionViewFlowLayout)?.headerReferenceSize = CGSize(width: 0, height: 0)
    $0.contentInsetAdjustmentBehavior = .never
    
    $0.backgroundColor = .clear
  }
  
  let renderer = Renderer(
      adapter: CustomCollectionViewAdapter(),
      updater: UICollectionViewUpdater()
  )
  
  private let backButton: UIButton = UIButton().then {
    $0.setImage(ImageProvider.back, for: .normal)
  }
  
  private let locationLabel: IconedLabel = IconedLabel()
  
  private let favoriteButton: UIButton = UIButton().then {
    $0.setImage(ImageProvider.favorite, for: .normal)
  }
  
  private let maximizeButton: UIButton = UIButton().then {
    $0.setImage(ImageProvider.expand, for: .normal)
  }
  
  private let nameLabel: Label = Label().then {
    $0.font = FontProvider.bigHeaderRegular
    $0.textColor = ColorProvider.whiteTextColor.color
  }
  
  private let pageView: YTPageStackView = YTPageStackView()
  
  public init() {
    super.init(frame: .zero)
    initialize()

  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func configureView(presenter: CampDetailComponentPresenterProtocol) {
    self.presenter = presenter
    
    loadUI()
    
    layoutIfNeeded()
    
    
    if let flow = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout) {
      flow.minimumInteritemSpacing = 0
      flow.minimumLineSpacing = 0
      flow.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: 350)
    }

    renderer.target = collectionView
    renderer.render(presenter.sections)
    
    renderer.adapter.itemShowedAtIndex = { [weak self] index in
      self?.presenter?.imageIndex = index
      self?.setupPageView()
    }
  }
  
  public func loadUI() {
    guard let presenter = presenter else {
      return
    }

    let locationPresenter = IconedLabelPresenter(title: presenter.location,
                                                 image: ImageProvider.mapPin,
                                                 textColor: ColorProvider.whiteTextColor.color)
    locationPresenter.textFont = FontProvider.listSmallRegular
    locationPresenter.space = 4
    locationPresenter.imageTintColor = ColorProvider.whiteTextColor.color
    locationPresenter.backgroundColor = ColorProvider.semiTransparentBg.color
    locationPresenter.radius = 10
    locationLabel.configureView(presenter: locationPresenter)
    
    nameLabel.text = presenter.name

    setupPageView()
  }
  
  private func setupPageView() {
    let presenter = YTPageStackViewPresenter(itemCount: self.presenter?.images.count ?? 0)
    presenter.selectedItemIndex = self.presenter?.imageIndex ?? 0
    pageView.configureView(presenter: presenter)
  }
}

extension CampDetailComponentView {
  func initialize() {
    setupViews()
    setupConstraints()
  }
  
  func setupViews() {
    addSubview(collectionView)
    addSubview(backButton)
    addSubview(favoriteButton)
    addSubview(maximizeButton)
    addSubview(locationLabel)
    addSubview(nameLabel)
    addSubview(pageView)
  }
  
  func setupConstraints() {
    collectionView.snp.makeConstraints {
      $0.leading.top.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.height.equalTo(350)
      $0.bottom.equalToSuperview()
    }
    
    backButton.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
      $0.leading.equalToSuperview()
      $0.height.equalTo(40)
      $0.width.equalTo(40)
    }
    
    favoriteButton.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
      $0.trailing.equalToSuperview()
      $0.height.equalTo(40)
      $0.width.equalTo(40)
    }
    
    locationLabel.snp.makeConstraints {
      $0.trailing.equalTo(favoriteButton.snp.leading).offset(-4)
      $0.centerY.equalTo(favoriteButton.snp.centerY)
      $0.height.equalTo(20)
    }
    
    maximizeButton.snp.makeConstraints {
      $0.trailing.equalToSuperview().offset(-16)
      $0.bottom.equalToSuperview().offset(-32)
      $0.height.equalTo(40)
      $0.width.equalTo(40)
    }
    
    nameLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
    }
    
    pageView.snp.makeConstraints {
      $0.leading.greaterThanOrEqualToSuperview().offset(16)
      $0.trailing.lessThanOrEqualToSuperview().offset(-16)
      $0.centerX.equalToSuperview()
      $0.bottom.equalToSuperview().offset(-8)
      $0.top.equalTo(nameLabel.snp.bottom).offset(8)
    }
  }
}
