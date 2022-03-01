//
//  WelcomeController.swift
//  CampApp
//
//  Created by Nurullah Vural on 14.02.2022.
//

import UIKit
import Common
import AttributedStringBuilder
import XCoordinator

final class WelcomeController: UIViewController, Storyboarded {
    
    private var presenter: WelcomePresenter!
 
    
    @IBOutlet public var collectionView: UICollectionView!
    @IBOutlet public var onboardingSmallLabel: UILabel!
    @IBOutlet public var onboardingBigLabel: UILabel!
    @IBOutlet public var frameView: UIView!
    @IBOutlet public var pageControl: UIPageControl!
    @IBOutlet public var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CampDefaults.setup(with: PersistentDomain.test)
        presenter.loadUI()
        pageControl.numberOfPages = presenter.images.count
        setupOnboardingHeader()
        setupWhiteFrame()
        setupButton()

    }
    public func setupPresenter(presenter: WelcomePresenter) {
        self.presenter = presenter
    }
    private func setupOnboardingHeader(){
        
        let onboardingSmallHeaderFont: [AttributedStringBuilder.Attribute] = [
            .font(FontProvider.onboardingSmall),
            .textColor(ColorProvider.whiteTextColor.color),
        ]
        let onboardingSmallHeaderText: NSAttributedString = AttributedStringBuilder().text(StringProvider.onboardingSmallText, attributes: onboardingSmallHeaderFont).attributedString
        onboardingSmallLabel.attributedText = onboardingSmallHeaderText
        
        
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
        
        onboardingBigLabel.attributedText = onboardingBigHeaderTextFirstPart.append(to: onboardingBigHeaderTextSecondPart)
    }
    private func setupWhiteFrame() {
        frameView.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        frameView.layer.borderWidth = 10
        frameView.layer.cornerRadius = 16
        frameView.backgroundColor = UIColor(white: 1, alpha: 0)
    }
    private func setupButton() {
        let buttonTextFont: [AttributedStringBuilder.Attribute] = [
            .font(FontProvider.onboardingButton),
            .textColor(ColorProvider.onboardingYellowButtonText.color),
        ]
        let buttonText: NSAttributedString = AttributedStringBuilder().text(presenter.images[pageControl.currentPage].name, attributes: buttonTextFont).attributedString
        button.setAttributedTitle(buttonText, for: .normal)
        button.backgroundColor = ColorProvider.onboardingButtonBackground.color
        button.addTarget(self, action: #selector(onBtnClick), for: .touchUpInside)
    }
    @objc private func onBtnClick(_ sender: UIButton) {
        print("touched \(sender.tag)")
        CampDefaults.shared.store(with: .onboardingAreaSelection, value: sender.titleLabel?.text)
        presenter.router.trigger(.campSelection, with: TransitionOptions(animated: true))
    }
    
}

extension WelcomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return presenter.cellForRow(at: indexPath, to: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        pageControl.currentPage =  Int(scrollView.contentOffset.x / width)
        self.setupButton()
        
    }
}


