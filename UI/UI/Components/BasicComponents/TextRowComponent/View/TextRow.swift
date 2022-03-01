//
//  TextRow.swift
//  YTUI
//
//  Created by Nurullah Vural on 28.02.2022.
//

import UIKit
import SnapKit
import Common

public final class TextRow: UIView {
    
    public var presenter: TextRowPresenterProtocol?
    private let rowLabel: Label = Label()
    private let imageView: UIImageView = UIImageView()
    
    public init() {
        super.init(frame: .zero)
        initialize()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureView(presenter: TextRowPresenterProtocol) {
        self.presenter = presenter
        loadUI()
    }
    public func loadUI() {
        guard let presenter = presenter else {
            return
        }
        view.backgroundColor = ColorProvider.lightGray.color
        rowLabel.text = presenter.text
        rowLabel.textColor = presenter.color
        rowLabel.font = presenter.font
        imageView.image = presenter.image
    }
}

extension TextRow {
    func initialize() {
        setupViews()
        setupConstraints()
    }
    func setupViews() {
        addSubview(rowLabel)
        addSubview(imageView)
    }
    
    func setupConstraints() {
        rowLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(200)
        }
        imageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalTo(rowLabel.snp.centerY)
            $0.width.equalTo(15)
            $0.height.equalTo(15)
        }
    }
}
