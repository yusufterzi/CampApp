//
//  MultilineTextView.swift
//  YTUI
//
//  Created by Nurullah Vural on 3.03.2022.
//


import Foundation
import UIKit
import Common
import Carbon

public final class MultilineTextView: UIView {
    
    public var presenter: MultilineTextViewPresenterProtocol?
    private var header: Label = Label()
    private let textView: UITextView = UITextView()
    
    public init() {
        super.init(frame: .zero)
        initialize()
        textView.delegate = self
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
        setupTextView()
        
    }
    private func setupTextView() {
        textView.text = presenter?.placeHolder
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.textColor = UIColor.placeholderText
        textView.backgroundColor = ColorProvider.lightGray.color
        textView.cornerRadius = 10
    }
    
}

extension MultilineTextView: UITextViewDelegate {
    func initialize() {
        setupViews()
        setupConstraints()
    }
    func setupViews() {
        addSubview(header)
        addSubview(textView)
        
    }
    func setupConstraints() {
        header.snp.makeConstraints{
            $0.top.equalToSuperview().offset(6)
            $0.trailing.equalToSuperview().offset(-16)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(15)
        }
        textView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom).offset(5)
            $0.trailing.equalToSuperview().offset(-16)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(170)
            $0.bottom.equalToSuperview().offset(-7)
        }
    }
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.placeholderText {
            textView.text = nil
            textView.textColor = ColorProvider.blackTextColor.color
        }
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
           setupTextView()
        }
    }
}

