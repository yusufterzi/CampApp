//
//  SegmentItemView.swift
//  YTUI
//
//  Created by yusuf terzi on 30.09.2021.
//

import Common
import Carbon
import SnapKit

public protocol SegmentItemViewProtocol: BaseView {
  
}

public final class SegmentItemView: UIView, Tappable, SegmentItemViewProtocol {
  
  private let button: UIButton = UIButton().then {
    $0.layer.cornerRadius = 12
  }
  
  public var presenter: SegmentItemPresenterProtocol?

  public init() {
    super.init(frame: .zero)
    initialize()

  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func configureView(presenter: SegmentItemPresenterProtocol?) {
    self.presenter = presenter
    
    loadUI()
  }
  
  public func loadUI() {
    guard let presenter = presenter else {
      return
    }
    
    button.setTitle(presenter.name, for: .normal)
    button.backgroundColor = presenter.backgroundColor
    button.setTitleColor(presenter.titleColor, for: .normal)
    button.titleLabel?.font = presenter.font
    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    
  }
  
  @objc func buttonTapped () {
    guard let presenter = presenter else {
      return
    }
    self.presenter?.onTap?(presenter)
  }
}

extension SegmentItemView {
  func initialize() {
    setupViews()
    setupConstraints()
  }
  
  func setupViews() {
    addSubview(button)
    
  }
  
  func setupConstraints() {
    button.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(0)
      $0.top.equalToSuperview().offset(4)
      $0.height.equalTo(24)
      $0.width.equalTo(70)
      $0.trailing.equalToSuperview().offset(-4)
      $0.bottom.equalToSuperview().offset(-8)
    }
    
  }
}
