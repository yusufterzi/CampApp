//
//  CampComponentView.swift
//  CampApp
//
//  Created by yusuf terzi on 24.09.2021.
//

import Foundation
import UIKit
import SDWebImage

public final class CampComponentView: UIView, BaseView {
  
  public typealias Presenter = CampComponentPresenter
  
  public var presenter: CampComponentPresenter?
  
  let imageView: UIImageView = UIImageView()
  let pointLabel: IconedLabel = IconedLabel()
  let locationLabel: IconedLabel = IconedLabel()
  let nameLabel: Label = Label().then {
    $0.font = FontProvider.listMidMedium
    $0.textColor = ColorProvider.darkTextColor
  }
  
  public init() {
    super.init(frame: .zero)
    initialize()

  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func configureView(presenter: CampComponentPresenter) {
    self.presenter = presenter
    presenter.view = self
    
    loadUI()
  }
  
  public func loadUI() {
    guard let presenter = presenter else {
      return
    }

    imageView.sd_setImage(with: URL(string: presenter.item.images?.first ?? ""))
    
    let starPresenter = IconedLabelPresenter(title: presenter.point,
                                             image: ImageProvider.star,
                                             textColor: ColorProvider.greenLabel)
    starPresenter.space = 4
    starPresenter.textFont = FontProvider.listSmallRegular
    pointLabel.configureView(presenter: IconedLabelPresenter(title: presenter.point,
                                                             image: ImageProvider.star,
                                                             textColor: ColorProvider.greenLabel))
    
    let locationPresenter = IconedLabelPresenter(title: presenter.location,
                                                 image: ImageProvider.mapPin,
                                                 textColor: ColorProvider.darkTextColor)
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
    }
  }
}
