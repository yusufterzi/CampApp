//
//  TwoRowIconedLabel.swift
//  YTUI
//
//  Created by yusuf terzi on 6.10.2021.
//

import UIKit
import Carbon
import Common

final class TwoRowIconedLabel: UIView, BaseView {

  public var presenter: TwoRowIconedLabelPresenter? = nil
  
  let hStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.spacing = 5
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
    $0.spacing = 4
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
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    if shadowLayer == nil {
      shadowLayer = CAShapeLayer()
      shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 18).cgPath
      shadowLayer.fillColor = UIColor.white.cgColor
      
      shadowLayer.shadowColor = UIColor.darkGray.cgColor
      shadowLayer.shadowPath = shadowLayer.path
      shadowLayer.shadowOffset = CGSize(width: 0, height: 2.0)
      shadowLayer.shadowOpacity = 0.8
      shadowLayer.shadowRadius = 4
      
      imageParent.layer.insertSublayer(shadowLayer, at: 0)
    }
  }

  public func loadUI() {
    guard let presenter = presenter else {
      return
    }
 
    self.nameLabel.text = presenter.title
    self.imageView.image = presenter.image
    if let tint = presenter.imageTintColor {
      self.imageView.tintColor = tint
    }

  }

  func initialize() {
    setupViews()
    setupConstraints()
  }
  
  func setupViews() {
    addSubview(hStackView)
    imageParent.addSubview(imageView)
    
    hStackView.addArrangedSubview(imageParent)
    
    nameStackView.addArrangedSubview(nameLabel)
    nameStackView.addArrangedSubview(descLabel)

    hStackView.addArrangedSubview(nameStackView)
    
    hStackView.spacing = 4
    nameLabel.font = FontProvider.listSmallRegular
  }
  
  func setupConstraints() {
    hStackView.snp.makeConstraints {
      $0.top.bottom.equalToSuperview()
      $0.leading.equalToSuperview().offset(8)
      $0.trailing.equalToSuperview().offset(-8)
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
