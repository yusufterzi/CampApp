//
//  ButtonView.swift
//  YTUI
//
//  Created by Nurullah Vural on 4.03.2022.
//

import UIKit
import SnapKit

public final class ButtonView: UIView {
    
    public var presenter: ButtonPresenterProtocol?
    
    private let button: UIButton = UIButton()
    
    
    public init() {
        super.init(frame: .zero)
        initialize()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureView(presenter: ButtonPresenterProtocol) {
        self.presenter = presenter
        
        loadUI()
    }
    
    public func loadUI() {
        guard let presenter = presenter else {
            return
        }
        button.backgroundColor = presenter.backgroundColor
        button.setTitle(presenter.text, for: UIControl.State.normal)
        button.setTitleColor(presenter.textColor, for: .normal)
        button.titleLabel?.font = presenter.textFont
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    @objc func buttonTapped () {
        self.presenter?.tapped?()
    }
}

extension ButtonView {
    func initialize() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(button)
        
    }
    
    func setupConstraints() {
        button.snp.makeConstraints {
            $0.leading.top.bottom.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
    }
}
