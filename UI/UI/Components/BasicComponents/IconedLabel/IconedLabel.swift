//
//  IconedLabel.swift
//  CampApp
//
//  Created by yusuf terzi on 24.09.2021.
//

import UIKit
import Carbon
import Common

open class IconedLabel: UIView, BaseView {

  public var presenter: IconedLabelPresenter? = nil
  
  let hStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.spacing = 5
  }
  
  internal let imageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  
  internal let nameLabel = Label().then {
    $0.lineBreakMode = .byTruncatingTail
  }
  
  public init() {
    super.init(frame: .zero)
    initialize()
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func configureView(presenter: IconedLabelPresenter) {
    self.presenter = presenter
    loadUI()
  }

  public func loadUI() {
    guard let presenter = presenter else {
      return
    }
 
    self.nameLabel.text = presenter.title
    self.imageView.image = presenter.image
    if let textColor = presenter.textColor {
      self.nameLabel.textColor  = textColor
    }
  }

  func initialize() {
    setupViews()
    setupConstraints()
  }
  
  func setupViews() {
    addSubview(hStackView)
    hStackView.addArrangedSubview(imageView)
    hStackView.addArrangedSubview(nameLabel)
    
    hStackView.spacing = presenter?.space ?? 4
    nameLabel.font = presenter?.textFont ?? FontProvider.listSmallRegular
  }
  
  func setupConstraints() {
    hStackView.snp.makeConstraints {
      $0.leading.top.trailing.bottom.equalToSuperview()
    }
    imageView.snp.makeConstraints {
      $0.width.equalTo(13)
    }
  }
}
