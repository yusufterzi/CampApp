//
//  ViewHeaderView.swift
//  YTUI
//
//  Created by yusuf terzi on 29.09.2021.
//

import Common
import Carbon
import SnapKit

public protocol ViewHeaderViewProtocol: BaseView {
  
}

public final class ViewHeaderView: UIView, ViewHeaderViewProtocol {
  
  private let firstLabel: Label = Label()
  private let secondLabel: Label = Label()
  
  public var presenter: ViewHeaderPresenterProtocol?
  
  public init() {
    super.init(frame: .zero)
    initialize()

  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func configureView(presenter: ViewHeaderPresenterProtocol?) {
    self.presenter = presenter
    
    loadUI()
  }
  
  public func loadUI() {
    guard let presenter = presenter else {
      return
    }

    firstLabel.attributedText = presenter.firstPart
    secondLabel.attributedText = presenter.secondPart
    
  }
}

extension ViewHeaderView {
  func initialize() {
    setupViews()
    setupConstraints()
  }
  
  func setupViews() {
    addSubview(firstLabel)
    addSubview(secondLabel)
  }
  
  func setupConstraints() {
    firstLabel.snp.makeConstraints {
      $0.leading.top.equalToSuperview().offset(24)
      $0.trailing.equalToSuperview().offset(-24)
    }
    
    secondLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(24)
      $0.trailing.equalToSuperview().offset(-16)
      $0.top.equalTo(firstLabel.snp.bottom).offset(4)
      $0.bottom.equalToSuperview().offset(-24)
    }

  }
}
