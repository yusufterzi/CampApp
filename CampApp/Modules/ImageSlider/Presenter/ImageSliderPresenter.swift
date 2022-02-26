//
//  ImageSliderPresenter.swift
//  CampApp
//
//  Created by Nurullah Vural on 21.02.2022.
//


import XCoordinator
import Carbon
import Common
import YTUI
import YTNetwork
import AttributedStringBuilder
import UIKit

protocol ImageSliderPresenterProtocol {
    
}

final class ImageSliderPresenter: ImageSliderPresenterProtocol {
    
    internal var router: UnownedRouter<HomeRoute>
    public var currentPage = 0
    public var images: [String]
    
    
    init(router: UnownedRouter<HomeRoute>, images: [String]) {
        self.router = router
        self.images = images
    }
    
    public func loadUI(viewController: ImageSliderController) {
        viewController.pageControl.numberOfPages = images.count
        setupButton(vc: viewController)
        
    }
    public func setupButton(vc: ImageSliderController) {
        vc.minimizeImageView.image = ImageProvider.minimize
        vc.containerView.cornerRadius = 20
        vc.containerView.applyBlurEffect(style: .regular)
        
        let caravanTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped(sender:)))
        vc.containerView.addGestureRecognizer(caravanTapGestureRecognizer)
        vc.containerView.isUserInteractionEnabled = true
    }
    
    @objc public func viewTapped(sender: UITapGestureRecognizer) {
        router.viewController.dismiss(animated: true)
    }
}




