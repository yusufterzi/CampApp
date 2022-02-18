//
//  WelcomePresenter.swift
//  CampApp
//
//  Created by Nurullah Vural on 14.02.2022.
//


import XCoordinator
import Carbon
import Common
import YTUI
import YTNetwork
import AttributedStringBuilder
import UIKit

protocol WelcomePresenterProtocol {
    
}

final class WelcomePresenter: WelcomePresenterProtocol {
    
    internal var router: UnownedRouter<MainRoute>
    
    public var currentPage = 0
    public var images: [WelcomeData] = [
        WelcomeData(name : "Marmara", image: ImageProvider.onboarding),
        WelcomeData(name : "Ege", image: ImageProvider.onboarding),
        WelcomeData(name : "Karadeniz", image: ImageProvider.onboarding),
        WelcomeData(name : "Akdeniz", image: ImageProvider.onboarding)
    ]
    
    init(router: UnownedRouter<MainRoute>) {
        self.router = router
        CampDefaults.setup(with: PersistentDomain.test)
    }
    public func loadUI(viewController: WelcomeController) {
        
        viewController.pageControl.numberOfPages = images.count
        setupOnboardingHeader(vc: viewController)
        setupWhiteFrame(vc: viewController)
        setupButton(vc: viewController)
    }
    public func setupOnboardingHeader(vc: WelcomeController){
        
        let onboardingSmallHeaderFont: [AttributedStringBuilder.Attribute] = [
            .font(FontProvider.onboardingSmall),
            .textColor(ColorProvider.whiteTextColor.color),
        ]
        let onboardingSmallHeaderText: NSAttributedString = AttributedStringBuilder().text(StringProvider.onboardingSmallText, attributes: onboardingSmallHeaderFont).attributedString
        vc.onboardingSmallLabel.attributedText = onboardingSmallHeaderText
        
        
        let onboardingBigHeaderFontFirstPart: [AttributedStringBuilder.Attribute] = [
            .font(FontProvider.onboardingBigRegular),
            .textColor(ColorProvider.blackTextColor.color),
        ]
        
        let onboardingBigHeaderTextFirstPart: NSAttributedString = AttributedStringBuilder().text(StringProvider.onboardingBigTextPartOne,
                                                                                                  attributes: onboardingBigHeaderFontFirstPart).attributedString
        
        let onboardingBigHeaderFontSecondPart: [AttributedStringBuilder.Attribute] = [
            .font(FontProvider.onboardingBigBold),
            .textColor(ColorProvider.onboardingRedColor.color),
        ]
        
        let onboardingBigHeaderTextSecondPart: NSAttributedString = AttributedStringBuilder().text(StringProvider.onboardingBigTextPartTwo,
                                                                                                   attributes: onboardingBigHeaderFontSecondPart).attributedString
        
        vc.onboardingBigLabel.attributedText = onboardingBigHeaderTextFirstPart.append(to: onboardingBigHeaderTextSecondPart)
    }
    
    public func setupWhiteFrame(vc: WelcomeController) {
        
        vc.frameView.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        vc.frameView.layer.borderWidth = 10
        vc.frameView.layer.cornerRadius = 16
        vc.frameView.backgroundColor = UIColor(white: 1, alpha: 0)
    }
    
    public func setupButton(vc: WelcomeController) {
        let buttonTextFont: [AttributedStringBuilder.Attribute] = [
            .font(FontProvider.onboardingButton),
            .textColor(ColorProvider.onboardingYellowButtonText.color),
        ]
        let buttonText: NSAttributedString = AttributedStringBuilder().text(images[vc.pageControl.currentPage].name, attributes: buttonTextFont).attributedString
        vc.button.setAttributedTitle(buttonText, for: .normal)
        vc.button.backgroundColor = ColorProvider.onboardingButtonBackground.color
        vc.button.addTarget(self, action: #selector(onBtnClick), for: .touchUpInside)
        
        
    }
    
    @objc private func onBtnClick(_ sender: UIButton) {
        print("touched \(sender.tag)")
        CampDefaults.shared.store(with: .onboardingAreaSelection, value: sender.titleLabel?.text)
        router.trigger(.campSelection, with: TransitionOptions(animated: true))
    }
}




