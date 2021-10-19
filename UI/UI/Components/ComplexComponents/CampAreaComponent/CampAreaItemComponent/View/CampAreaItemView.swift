//
//  CampAreaItemView.swift
//  YTUI
//
//  Created by yusuf terzi on 3.10.2021.
//

import Foundation

import Common
import Carbon
import SnapKit
import SDWebImage

public protocol CampAreaItemViewProtocol: BaseView {
  
}

public final class CampAreaItemView: UIView, CampAreaItemViewProtocol {
  
  private let image: UIImageView = UIImageView().then {
    $0.layer.cornerRadius = 5
    $0.clipsToBounds = true
  }
  
  private let nameLabel: Label = Label().then {
    $0.font = FontProvider.regular14
    $0.textColor = ColorProvider.darkGrayTextColor.color
  }
  
  private let campCountLabel: IconedLabel = IconedLabel()
  
  public var presenter: CampAreaItemPresenterProtocol?

  public init() {
    super.init(frame: .zero)
    initialize()

  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func configureView(presenter: CampAreaItemPresenterProtocol?) {
    self.presenter = presenter
    
    loadUI()
  }
  
  public func loadUI() {
    guard let presenter = presenter else {
      return
    }
    image.sd_setImage(with: URL(string: presenter.image))

    nameLabel.text = presenter.name
    
    let countPresenter = IconedLabelPresenter(title: String(format: StringProvider.campCount, presenter.areaCount),
                                              image: ImageProvider.mapPin,
                                              textColor: ColorProvider.greenLabel.color)
    countPresenter.imageTintColor = ColorProvider.greenLabel.color
    campCountLabel.configureView(presenter: countPresenter)
    
  }
}

extension CampAreaItemView {
  func initialize() {
    setupViews()
    setupConstraints()
  }
  
  func setupViews() {
    addSubview(image)
    addSubview(nameLabel)
    addSubview(campCountLabel)
  }
  
  func setupConstraints() {
    image.snp.makeConstraints {
      $0.leading.trailing.top.equalToSuperview()
      $0.top.equalToSuperview().offset(4)
      $0.height.equalTo(115)
      $0.width.equalTo(200)
    }
    nameLabel.snp.makeConstraints {
      $0.top.equalTo(image.snp.bottom).offset(6)
      $0.leading.trailing.equalToSuperview()
    }
    
    campCountLabel.snp.makeConstraints {
      $0.top.equalTo(nameLabel.snp.bottom).offset(4)
      $0.leading.trailing.equalToSuperview().offset(-7)
      $0.bottom.equalToSuperview()
    }
  }
}
