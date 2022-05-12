//
//  SelectionRowView.swift
//  YTUI
//
//  Created by Nurullah Vural on 12.05.2022.
//

import UIKit
import Carbon
import Common

final class SelectionRowView: UIView, Tappable, BaseView {

  public var presenter: SelectionRowPresenter? = nil
  
  internal let checkImage = UIImageView()
  internal let textLabel = Label().then {
    $0.textColor = ColorProvider.blackTextColor.color
    $0.font = FontProvider.regular17
    $0.edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 120)
  }
  
  public init() {
    super.init(frame: .zero)
    initialize()
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func configureView(presenter: SelectionRowPresenter?) {
    self.presenter = presenter
    loadUI()
  }

  public func loadUI() {
    guard let presenter = presenter else {
      return
    }
    self.view.backgroundColor = ColorProvider.lightGray.color
    self.view.cornerRadius = 10
    textLabel.text = presenter.item.text
    checkImage.image = ImageProvider.check
    checkImage.isHidden = presenter.isSelected ? false : true
    
    onTap { [weak self] in
      self?.presenter?.isSelected.toggle()
      self?.presenter?.onTap?(presenter)
    }
 
  }

  func initialize() {
    setupViews()
    setupConstraints()
  }
  
  func setupViews() {
    addSubview(textLabel)
    addSubview(checkImage)

  }
  
  func setupConstraints() {
    
    textLabel.snp.makeConstraints{
      $0.top.equalToSuperview().offset(11)
      $0.leading.equalToSuperview().offset(16)
      $0.bottom.equalToSuperview().offset(-11)
    }
    
    checkImage.snp.makeConstraints {
      $0.top.equalToSuperview().offset(10)
      $0.trailing.equalToSuperview().offset(-10)
      $0.bottom.equalToSuperview().offset(-10)
      $0.width.equalTo(24)
    }
  
  }
}
