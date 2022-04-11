//
//  CampAreaCollectionView.swift
//  YTUI
//
//  Created by Nurullah Vural on 4.03.2022.
//


import Foundation
import UIKit
import SDWebImage
import Common
import Carbon

public protocol CampAreaCollectionViewProtocol {
    
}

public final class CampAreaCollectionView: UIView, CampAreaCollectionViewProtocol {
    
    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.isScrollEnabled = true
        $0.alwaysBounceHorizontal = true
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        ($0.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
        $0.backgroundColor = .clear
    }
    let renderer = Renderer(
        adapter: UICollectionViewFlowLayoutAdapter(),
        updater: UICollectionViewUpdater()
    )
    
    public var presenter: CampAreaCollectionPresenterProtocol?
    
    public init() {
        super.init(frame: .zero)
        initialize()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureView(presenter: CampAreaCollectionPresenterProtocol) {
        self.presenter = presenter
        
        layoutIfNeeded()
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize = CGSize(width: 120, height: 120)
        renderer.target = collectionView
        self.presenter?.reloadData = { [weak self]  in
            self?.renderer.render(self?.presenter?.sections ?? [])
            self?.presenter?.selectedImagesHandler?(self?.presenter?.selectedImages ?? [])
        }
        renderer.render(presenter.sections)
    }
    
}

extension CampAreaCollectionView {
    func initialize() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(collectionView)
        
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(10)
            $0.height.equalTo(120)
            $0.bottom.equalToSuperview().offset(-10)
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
}
