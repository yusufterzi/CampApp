//
//  CampComponentView.swift
//  CampApp
//
//  Created by yusuf terzi on 24.09.2021.
//

import Foundation
import UIKit
import SDWebImage
import Common

public protocol CampComponentViewProtocol {
  
}

public final class CampComponentView: UIView, CampComponentViewProtocol {
  
  public var presenter: CampComponentPresenterProtocol?
  
  private let imageView: UIImageView = UIImageView().then {
    $0.layer.cornerRadius = 12
    $0.clipsToBounds = true
  }
  private let pointLabel: IconedLabel = IconedLabel()
  private let locationLabel: IconedLabel = IconedLabel()
  private let nameLabel: Label = Label().then {
    $0.font = FontProvider.listMidMedium
    $0.textColor = ColorProvider.darkTextColor.color
  }
  
  public init() {
    super.init(frame: .zero)
    initialize()

  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func configureView(presenter: CampComponentPresenterProtocol) {
    self.presenter = presenter
    
    loadUI()
  }
  
  public func loadUI() {
    guard let presenter = presenter else {
      return
    }

    imageView.sd_setImage(with: URL(string: presenter.image))
    
    let starPresenter = IconedLabelPresenter(title: presenter.point,
                                             image: ImageProvider.star,
                                             textColor: ColorProvider.greenLabel.color)
    starPresenter.space = 4
    starPresenter.textFont = FontProvider.listSmallRegular
    pointLabel.configureView(presenter: starPresenter)
    
    let locationPresenter = IconedLabelPresenter(title: presenter.location,
                                                 image: ImageProvider.mapPin,
                                                 textColor: ColorProvider.darkTextColor.color)
    locationPresenter.textFont = FontProvider.listSmallRegular
    locationPresenter.space = 4
    locationLabel.configureView(presenter: locationPresenter)
  }
}

extension CampComponentView {
  func initialize() {
    setupViews()
    setupConstraints()
  }
  
  func setupViews() {
    addSubview(imageView)
    addSubview(pointLabel)
    addSubview(locationLabel)
    addSubview(nameLabel)

  }
  
  func setupConstraints() {
    imageView.snp.makeConstraints {
      $0.leading.top.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
      $0.height.equalTo(210)
    }
    
    pointLabel.snp.makeConstraints {
      $0.trailing.equalToSuperview().offset(-16)
      $0.top.equalTo(imageView.snp.bottom).offset(16)
      $0.height.equalTo(18)
    }
    
    locationLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(16)
      $0.top.equalTo(imageView.snp.bottom).offset(16)
      $0.height.equalTo(18)
    }
    
    nameLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
      $0.top.equalTo(imageView.snp.bottom).offset(16)
      $0.bottom.equalToSuperview().offset(-16)
    }
  }
}
