//
//  CampSelectionPresenter.swift
//  CampApp
//
//  Created by Nurullah Vural on 15.02.2022.
//

import Foundation
import XCoordinator
import Carbon
import Common
import YTUI
import YTNetwork
import AttributedStringBuilder
import UIKit

protocol CampSelectionPresenterProtocol {
    
}

final class CampSelectionPresenter: CampSelectionPresenterProtocol {
    internal var router: UnownedRouter<MainRoute>
    public var onTap: VoidHandler?
    
    init(router: UnownedRouter<MainRoute>) {
        self.router = router
    }
    
    public func loadUI(viewController: CampSelectionController) {
        setupLabel(viewController: viewController)
        setupViews(viewController: viewController)
        setupImages(viewController: viewController)
        
    }
    public func setupLabel(viewController: CampSelectionController) {
        
        let titleFontFirstPart: [AttributedStringBuilder.Attribute] = [
            .font(FontProvider.onboardingBigRegular),
            .textColor(ColorProvider.blackTextColor.color),
        ]
        
        let titleFirstPart: NSAttributedString = AttributedStringBuilder().text(StringProvider.campSelectionFirstPart, attributes: titleFontFirstPart).attributedString
        
        let titleFontSecondPart: [AttributedStringBuilder.Attribute] = [
            .font(FontProvider.onboardingBigBold),
            .textColor(ColorProvider.onboardingRedColor.color),
        ]
        
        let titleSecondPart: NSAttributedString = AttributedStringBuilder().text(StringProvider.campSelectionSecondPart, attributes: titleFontSecondPart).attributedString
        viewController.titleLabel.attributedText = titleFirstPart.append(to: titleSecondPart)
        
        let campSelectionFont: [AttributedStringBuilder.Attribute] = [
            .font(FontProvider.campSelectionFont),
            .textColor(ColorProvider.campSelectionLabelColor.color),
        ]
        let caravanLabelText: NSAttributedString = AttributedStringBuilder().text(StringProvider.caravanAreas, attributes: campSelectionFont).attributedString
        let tentLabelText: NSAttributedString = AttributedStringBuilder().text(StringProvider.tentAreas, attributes: campSelectionFont).attributedString
        let bungalowLabelText: NSAttributedString = AttributedStringBuilder().text(StringProvider.bungalowAreas, attributes: campSelectionFont).attributedString
        
        viewController.caravanLabel.attributedText = caravanLabelText
        viewController.caravanLabel.textAlignment = .center
        viewController.tentLabel.attributedText = tentLabelText
        viewController.tentLabel.textAlignment = .center
        viewController.bungalowLabel.attributedText = bungalowLabelText
        viewController.bungalowLabel.textAlignment = .center
        
    }
    public func setupViews(viewController: CampSelectionController) {
        
        viewController.mainView.backgroundColor = UIColor(white: 1, alpha: 0)
        viewController.mainView.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        viewController.caravanView.backgroundColor = UIColor(white: 1, alpha: 1)
        viewController.caravanView.layer.cornerRadius = 34
        viewController.caravanView.layer.borderWidth = 1
        viewController.caravanView.layer.borderColor = ColorProvider.campSelectionFrameColor.color.cgColor
        
        viewController.tentView.backgroundColor = UIColor(white: 1, alpha: 1)
        viewController.tentView.layer.cornerRadius = 34
        viewController.tentView.layer.borderWidth = 1
        viewController.tentView.layer.borderColor = ColorProvider.campSelectionFrameColor.color.cgColor
        
        viewController.bungalowView.backgroundColor = UIColor(white: 1, alpha: 1)
        viewController.bungalowView.layer.cornerRadius = 34
        viewController.bungalowView.layer.borderWidth = 1
        viewController.bungalowView.layer.borderColor = ColorProvider.campSelectionFrameColor.color.cgColor
    }
    
    public func setupImages(viewController: CampSelectionController) {
        viewController.caravanImageView.image = ImageProvider.caravan
        viewController.tentImageView.image = ImageProvider.tent
        viewController.bungalowImageView.image = ImageProvider.bungalow
    }
}
