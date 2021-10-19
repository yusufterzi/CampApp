//
//  CampDetailDistanceView.swift
//  YTUI
//
//  Created by yusuf terzi on 6.10.2021.
//

import Foundation
import Common
import UIKit
import SnapKit

public final class CampDetailDistanceView: UIView {
  
  public var presenter: ImagePresenterProtocol?
  
  private let starView: TwoRowIconedLabel = TwoRowIconedLabel()
  private let distanceView: TwoRowIconedLabel = TwoRowIconedLabel()
  private let pointView: TwoRowIconedLabel = TwoRowIconedLabel()
  private let stackView: UIStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.spacing = 8
  }
  
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
    
    let startPresenter = TwoRowIconedLabelPresenter(title: StringProvider.likes,
                                                    secondTitle: "",
                                                    image: ImageProvider.star)
    starView.configureView(presenter: startPresenter)
    
    let distancePresenter = TwoRowIconedLabelPresenter(title: StringProvider.distance,
                                                    secondTitle: "",
                                                    image: ImageProvider.distance)
    distanceView.configureView(presenter: distancePresenter)
    
    let pointPresenter = TwoRowIconedLabelPresenter(title: StringProvider.distance,
                                                    secondTitle: "",
                                                    image: ImageProvider.star)
    pointView.configureView(presenter: pointPresenter)
    
  }
}

extension CampDetailDistanceView {
  func initialize() {
    setupViews()
    setupConstraints()
  }
  
  func setupViews() {
    addSubview(stackView)
    
    stackView.addArrangedSubview(starView)
    stackView.addArrangedSubview(distanceView)
    stackView.addArrangedSubview(pointView)

  }
  
  func setupConstraints() {
    stackView.snp.makeConstraints {
      $0.leading.top.equalTo(20)
      $0.trailing.bottom.equalTo(-20)
      $0.height.equalTo(40)
    }
  }
}
