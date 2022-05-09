//
//  ImageView.swift
//  YTUI
//
//  Created by yusuf terzi on 4.10.2021.
//

import UIKit
import SnapKit

public final class ImageView: UIView {
  
  public var presenter: ImagePresenterProtocol?
  
  private let imageView: UIImageView = UIImageView()
  
  
  public init() {
    super.init(frame: .zero)
    initialize()
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func configureView(presenter: ImagePresenterProtocol) {
    self.presenter = presenter
    
    loadUI()
  }
  
  public func loadUI() {
    guard let presenter = presenter else {
      return
    }
    
    imageView.sd_setImage(with: presenter.item.imageReference)
    
    imageView.layer.cornerRadius = presenter.item.cornerRadius
    imageView.contentMode = presenter.item.contentMode
    clipsToBounds = true
    imageView.snp.remakeConstraints {
      $0.leading.top.bottom.trailing.equalToSuperview()
      $0.height.equalTo(presenter.item.size.height)
      $0.width.equalTo(presenter.item.size.width)
    }
  }
}

extension ImageView {
  func initialize() {
    setupViews()
    setupConstraints()
  }
  
  func setupViews() {
    addSubview(imageView)
    
  }
  
  func setupConstraints() {
    imageView.snp.makeConstraints {
      $0.leading.top.bottom.trailing.equalToSuperview()
      $0.height.equalTo(100)
      $0.height.equalTo(100)
    }
  }
}
