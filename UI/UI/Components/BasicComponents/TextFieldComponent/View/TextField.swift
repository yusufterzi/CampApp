//
//  TextField.swift
//  YTUI
//
//  Created by Nurullah Vural on 2.03.2022.
//
import Foundation
import UIKit
import Common
import Carbon

public final class TextField: UIView ,Tappable {
    
    public var presenter: TextFieldPresenterProtocol?
    private var header: Label = Label()
    private let textField: UITextField = UITextField()
    private let imageView: UIImageView = UIImageView()
    
    public init() {
        super.init(frame: .zero)
        textField.delegate = self
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureView() {
        loadUI()
    }
    public func loadUI() {
        guard let presenter = presenter else {
            return
        }
        header.text = presenter.headerTitle
        header.textColor = presenter.headerColor
        header.font = presenter.headerFont
        header.edgeInsets = presenter.headerEdgeInsets ?? UIEdgeInsets.zero
        imageView.image = presenter.image
        setupTextField()
        onTap { [weak self] in
            self?.presenter?.onTap?()
        }
        
    }
    private func setupTextField(){
        textField.placeholder = presenter?.placeHolder
        textField.backgroundColor = ColorProvider.lightGray.color
        textField.isUserInteractionEnabled = presenter?.isUserInteractionEnabled ?? true
        textField.cornerRadius = 10
    }
}

extension TextField: UITextFieldDelegate {
    func initialize() {
        setupViews()
        setupConstraints()
    }
    func setupViews() {
        addSubview(header)
        addSubview(textField)
        addSubview(imageView)
        
        
    }
    func setupConstraints() {
        
        header.snp.makeConstraints{
            $0.top.equalToSuperview().offset(6)
            $0.trailing.equalToSuperview().offset(-16)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(15)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom).offset(5)
            $0.trailing.equalToSuperview().offset(-16)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(40)
            $0.bottom.equalToSuperview().offset(-7)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(textField.snp.top).offset(8)
            $0.trailing.equalTo(textField.snp.trailing).offset(-8)
            $0.height.equalTo(24)
            $0.width.equalTo(24)
        }
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            if !text.isEmpty {
                self.presenter?.textEdited?(text)
            }
        }
    }
    
}
