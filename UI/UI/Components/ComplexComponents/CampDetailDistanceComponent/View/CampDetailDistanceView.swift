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
    
    public var presenter: CampDetailDistancePresenterProtocol?
    private let starView: TwoRowIconedLabel = TwoRowIconedLabel()
    private let distanceView: TwoRowIconedLabel = TwoRowIconedLabel()
    private let pointView: TwoRowIconedLabel = TwoRowIconedLabel()
    private let stackView: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 21
        $0.distribution = .fillEqually
    }
    
    public init() {
        super.init(frame: .zero)
        initialize()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureView(presenter: CampDetailDistancePresenterProtocol) {
        self.presenter = presenter
        
        loadUI()
    }
    
    public func loadUI() {
        
        let startPresenter = TwoRowIconedLabelPresenter(title: StringProvider.likes,
                                                        secondTitle: "4.8 (3.2k)",
                                                        image: ImageProvider.star)
        startPresenter.imageTintColor = ColorProvider.starYellow.color
        starView.configureView(presenter: startPresenter)
        
        let distancePresenter = TwoRowIconedLabelPresenter(title: StringProvider.distance,
                                                           secondTitle: "346 km",
                                                           image: ImageProvider.distance)
        distanceView.configureView(presenter: distancePresenter)
        
        let pointPresenter = TwoRowIconedLabelPresenter(title: StringProvider.rate,
                                                        secondTitle: "85",
                                                        image: ImageProvider.star)
        pointPresenter.imageTintColor = ColorProvider.starRed.color
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
            $0.top.equalTo(40)
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
            $0.height.equalTo(36)
        }
    }
}
