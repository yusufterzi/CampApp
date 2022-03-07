//
//  CampAreaImageView.swift
//  YTUI
//
//  Created by Nurullah Vural on 4.03.2022.
//

import Common
import Carbon
import SnapKit
import SDWebImage
import UIKit

public protocol CampAreaImageViewProtocol: BaseView {
    
}

public final class CampAreaImageView: UIView, CampAreaImageViewProtocol {
    private var selectedImages: [UIImage] = [UIImage]()
    private let image: UIImageView = UIImageView().then {
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    }
    private let addImage: UIImageView = UIImageView().then {
        $0.clipsToBounds = true
    }
    private let removeImage: UIImageView = UIImageView().then {
        $0.clipsToBounds = true
    }
    internal let textLabel = UILabel().then {
        $0.textColor = ColorProvider.whiteTextColor.color
        $0.font = FontProvider.bold12
        $0.textAlignment = .center
    }
    
    public var presenter: CampAreaImageItemPresenterProtocol?
    
    public init() {
        super.init(frame: .zero)
        initialize()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configureView(presenter: CampAreaImageItemPresenterProtocol?) {
        self.presenter = presenter
        loadUI()
    }
    public func loadUI() {
        guard let presenter = presenter else {
            return
        }
        setupView()
        setupTapGestureRecognizer()
    }
    private func setupView() {
        view?.layer.borderWidth = 1
        view?.layer.borderColor = ColorProvider.segmentItemSelectedText.color.cgColor
        view.layer.cornerRadius = 10
        
        addImage.image = presenter?.addImage
        removeImage.image = presenter?.removeImage
        image.image = presenter?.image
        image.cornerRadius = 10
        textLabel.text = presenter?.text
        
        image.isUserInteractionEnabled = true
        
        addImage.isUserInteractionEnabled = addImage.image != nil
        removeImage.isUserInteractionEnabled = removeImage.image != nil
      
    }
    
    private func setupTapGestureRecognizer() {
        let addImageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addImageButtonTapped(sender:)))
        addImage.addGestureRecognizer(addImageGestureRecognizer)
        
        let removeImageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(removeImageButtonTapped(sender:)))
        removeImage.addGestureRecognizer(removeImageGestureRecognizer)
        
    }
    
    @objc func addImageButtonTapped(sender: UITapGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        self.parentViewController?.present(picker, animated: true)

    }
    @objc func removeImageButtonTapped(sender: UITapGestureRecognizer) {
        if let image = image.image {
            self.presenter?.removeImageHandler?(image)
        }
    }
}

extension CampAreaImageView {
    func initialize() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        image.addSubview(addImage)
        image.addSubview(removeImage)
        image.addSubview(textLabel)
        addSubview(image)
    }
    
    func setupConstraints() {
        image.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
            $0.height.equalTo(100)
            $0.width.equalTo(100)
        }
        addImage.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(40)
            $0.trailing.bottom.equalToSuperview().offset(-40)
            $0.height.equalTo(20)
            $0.width.equalTo(20)
        }
        
        removeImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(6)
            $0.trailing.equalToSuperview().offset(-6)
            $0.height.equalTo(20)
            $0.width.equalTo(20)
        }
        textLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-4)
            $0.centerX.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-17)
            $0.leading.equalToSuperview().offset(17)
            $0.height.equalTo(14)
        }
        
    }
}

extension CampAreaImageView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        picker.dismiss(animated: true)
        selectedImages.append(image)
        self.presenter?.addImageHandler?(image)
    }
    
}
