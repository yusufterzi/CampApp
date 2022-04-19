//
//  YTPageStackView.swift
//  YTUI
//
//  Created by yusuf terzi on 1.10.2021.
//

import UIKit

final class YTPageStackView: UIView, BaseView {

  var presenter: YTPageStackViewPresenterProtocol? = nil

  private var stackView: UIStackView = UIStackView()
  
  public init() {
    super.init(frame: .zero)
    initialize()
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func configureView(presenter: YTPageStackViewPresenterProtocol?) {
    self.presenter = presenter
    
    self.presenter?.indexChangeHandler = { [weak self] _ in
      self?.setupPages()
    }
    
    loadUI()
  }
  
  internal func loadUI() {
    stackView.axis = .horizontal
    stackView.spacing = 6
    setupPages()
  }
}

private extension YTPageStackView {
  func initialize() {
    setupViews()
    setupConstraints()
  }
  
    func setupPages() {
        stackView.removeArrangedSubviews()
        guard let presenter = presenter else { return }
        if presenter.itemCount > 0 {
            for index in 0...(presenter.itemCount - 1) {
                let view = UIView()
                view.backgroundColor = .white.withAlphaComponent(0.5)
                view.layer.cornerRadius = 3
                stackView.addArrangedSubview(view)
                view.snp.makeConstraints {
                    $0.height.equalTo(6)
                    if index == presenter.selectedItemIndex {
                        $0.width.equalTo(25)
                        view.backgroundColor = .white
                    } else {
                        $0.width.equalTo(6)
                    }
                }
            }
            
        }
    }
  
  func setupViews() {
    addSubview(stackView)
  }
  
  func setupConstraints() {
    stackView.snp.makeConstraints {
      $0.leading.top.trailing.bottom.equalToSuperview()
    }
  }
}
