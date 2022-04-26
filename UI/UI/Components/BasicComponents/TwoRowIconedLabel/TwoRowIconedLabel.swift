//
//  TwoRowIconedLabel.swift
//  YTUI
//
//  Created by yusuf terzi on 6.10.2021.
//

import UIKit
import Carbon
import Common

final class TwoRowIconedLabel: UIView, Tappable, BaseView {
  
  public var presenter: TwoRowIconedLabelPresenter? = nil
  
  internal let hStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.spacing = 8
  }
  
  internal let imageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  
  internal let imageParent = UIView().then {
    $0.backgroundColor = ColorProvider.whiteTextColor.color
  }
  
  internal let nameLabel = Label().then {
    $0.lineBreakMode = .byTruncatingTail
    $0.font = FontProvider.light10
    $0.textColor = ColorProvider.lowTextColor.color
  }
  
  internal let descLabel = Label().then {
    $0.lineBreakMode = .byTruncatingTail
    $0.font = FontProvider.regular12
    $0.textColor = ColorProvider.highTextColor.color
  }
  
  private var shadowLayer: CAShapeLayer!
  
  let nameStackView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 2
    $0.distribution = .fillEqually
  }
  
  public init() {
    super.init(frame: .zero)
    initialize()
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func configureView(presenter: TwoRowIconedLabelPresenter?) {
    self.presenter = presenter
    loadUI()
  }
  
  
  public func loadUI() {
    guard let presenter = presenter else {
      return
    }
    
    self.nameLabel.text = presenter.title
    self.imageView.image = presenter.image
    self.descLabel.text = presenter.secondTitle
    self.imageParent.addCircleShadow()
    if let tint = presenter.imageTintColor {
      self.imageView.tintColor = tint
    }
    
  }
  
  private func initialize() {
    setupViews()
    setupConstraints()
    onTap { [weak self] in
      self?.presenter?.onTap?()
    }
    
  }
  
  private func setupViews() {
    addSubview(hStackView)
    imageParent.addSubview(imageView)
    
    hStackView.addArrangedSubview(imageParent)
    
    nameStackView.addArrangedSubview(nameLabel)
    nameStackView.addArrangedSubview(descLabel)
    
    hStackView.addArrangedSubview(nameStackView)
    nameLabel.font = FontProvider.listSmallRegular
  }
  
  private func setupConstraints() {
    hStackView.snp.makeConstraints {
      $0.top.bottom.equalToSuperview()
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
    }
    
    imageParent.snp.makeConstraints {
      $0.width.equalTo(36)
      $0.height.equalTo(36)
    }
    
    imageView.snp.makeConstraints {
      $0.width.equalTo(24)
      $0.height.equalTo(24)
      $0.centerX.centerY.equalToSuperview()
    }
    
  }
}
