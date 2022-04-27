//
//  CampDetailView.swift
//  YTUI
//
//  Created by yusuf terzi on 3.10.2021.
//


import Foundation
import UIKit
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
  
  internal let textLabel = UILabel().then {
    $0.textColor = ColorProvider.blackTextColor.color
    $0.font = FontProvider.campDetailTextFont
    $0.numberOfLines = 0
  }
  
  private let backButton: UIButton = UIButton().then {
    $0.setImage(ImageProvider.back, for: .normal)
  }
  private let locationLabel: IconedLabel = IconedLabel()
  
  private let expandView: UIView = UIView().then {
    $0.isUserInteractionEnabled = true
  }
  private let expandImageView: UIImageView = UIImageView().then {
    $0.image = ImageProvider.maximize
  }
  
  private let nameLabel: Label = Label().then {
    $0.font = FontProvider.bigHeaderRegular
    $0.textColor = ColorProvider.whiteTextColor.color
  }
  
  private let pageView: YTPageStackView = YTPageStackView()
  private let distanceView: CampDetailDistanceView = CampDetailDistanceView()
  
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
    collectionView.layer.cornerRadius = 32
    collectionView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
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
    nameLabel.text = presenter.name
    textLabel.text = presenter.description
    setupLocationLabel(presenter: presenter)
    setupPageView()
    setupDistanceView()
    setupButtons()
  }
  private func setupButtons() {
    backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
    expandView.applyBlurEffect(style: .regular, cornerRadius: 20)
    
    let expandViewTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(maximizeButtonClicked(sender:)))
    expandView.addGestureRecognizer(expandViewTapRecognizer)
    
    
  }
  private func setupLocationLabel(presenter: CampDetailComponentPresenterProtocol) {
    let locationPresenter = IconedLabelPresenter(title: presenter.location,
                                                 image: ImageProvider.mapPin,
                                                 textColor: ColorProvider.whiteTextColor.color)
    locationPresenter.textFont = FontProvider.listSmallRegular
    locationPresenter.space = 4
    locationPresenter.imageTintColor = ColorProvider.whiteTextColor.color
    locationPresenter.backgroundColor = ColorProvider.semiTransparentBg.color
    locationPresenter.radius = 10
    locationLabel.configureView(presenter: locationPresenter)
  }
  private func setupPageView() {
    let presenter = YTPageStackViewPresenter(itemCount: self.presenter?.images.count ?? 0)
    presenter.selectedItemIndex = self.presenter?.imageIndex ?? 0
    pageView.configureView(presenter: presenter)
  }
  
  private func setupDistanceView() {
    let width = UIScreen.main.bounds.width
    let presenter = CampDetailDistancePresenter(size: CGSize(width: width, height: 110), image: "", cornerRadius: 0)
    presenter.likeHandler = { [weak self] in
      self?.presenter?.liked?()
    }
    distanceView.configureView(presenter: presenter)
    
  }
  @objc func backButtonClicked () {
    if let backButtonTapped = self.presenter?.backButtonTapped {
      backButtonTapped()
    }
  }
  @objc func maximizeButtonClicked (sender: UITapGestureRecognizer) {
    if let maximizeButtonTapped = self.presenter?.maximizeButtonTapped {
      maximizeButtonTapped(presenter?.images ?? [])
    }
  }
  
  
}

extension CampDetailComponentView {
  func initialize() {
    setupViews()
    setupConstraints()
  }
  
  func setupViews() {
    addSubview(collectionView)
    addSubview(distanceView)
    addSubview(backButton)
    
    expandView.addSubview(expandImageView)
    addSubview(expandView)
    addSubview(locationLabel)
    addSubview(nameLabel)
    addSubview(pageView)
    addSubview(textLabel)
  }
  
  func setupConstraints() {
    collectionView.snp.makeConstraints {
      $0.leading.top.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.height.equalTo(350)
    }
    distanceView.snp.makeConstraints {
      $0.top.equalTo(collectionView.snp.bottom)
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.height.equalTo(110)
      
    }
    backButton.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
      $0.leading.equalToSuperview()
      $0.height.equalTo(40)
      $0.width.equalTo(40)
    }
    
    locationLabel.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(35)
      $0.trailing.equalToSuperview().offset(-20)
      $0.height.equalTo(20)
    }
    
    expandView.snp.makeConstraints {
      $0.trailing.equalToSuperview().offset(-20)
      $0.bottom.equalTo(collectionView.snp.bottom).offset(-32)
      $0.height.equalTo(44)
      $0.width.equalTo(44)
    }
    
    expandImageView.snp.makeConstraints {
      $0.centerX.centerY.equalToSuperview()
      $0.height.equalTo(20)
      $0.width.equalTo(20)
    }
    
    nameLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalTo(expandView.snp.leading).offset(-20)
      $0.bottom.equalTo(pageView.snp.top).offset(-8)
    }
    
    pageView.snp.makeConstraints {
      $0.leading.greaterThanOrEqualToSuperview().offset(16)
      $0.trailing.lessThanOrEqualToSuperview().offset(-16)
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(collectionView.snp.bottom).offset(-8)
    }
    
    textLabel.snp.makeConstraints {
      $0.top.equalTo(distanceView.snp.bottom).offset(16)
      $0.bottom.equalToSuperview().offset(-16)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
    }
  }
}
