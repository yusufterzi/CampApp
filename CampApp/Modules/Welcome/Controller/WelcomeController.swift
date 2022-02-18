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
        
    private var presenter: WelcomePresenter?
    
    @IBOutlet public var collectionView: UICollectionView!
    @IBOutlet public var onboardingSmallLabel: UILabel!
    @IBOutlet public var onboardingBigLabel: UILabel!
    @IBOutlet public var frameView: UIView!
    @IBOutlet public var pageControl: UIPageControl!
    @IBOutlet public var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadUI(viewController: self)
    }
    
    public func setupPresenter(presenter: WelcomePresenter) {
      self.presenter = presenter
    }
    
}

extension WelcomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WelcomeCell.identifier, for: indexPath) as! WelcomeCell
        cell.setup(presenter?.images[indexPath.item] ?? WelcomeData(name: "", image: UIImage()))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        pageControl.currentPage =  Int(scrollView.contentOffset.x / width)
        presenter?.setupButton(vc: self)
        
    }
}


