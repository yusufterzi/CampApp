//
//  ImageSliderController.swift
//  CampApp
//
//  Created by Nurullah Vural on 21.02.2022.
//
import Foundation
import UIKit
import Common
import XCoordinator

final class ImageSliderController: UIViewController, Storyboarded  {
    private var presenter: ImageSliderPresenter!

    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var pageControl: UIPageControl!
    @IBOutlet private var minimizeImageView: UIImageView!
    @IBOutlet private var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorProvider.whiteTextColor.color
        collectionView.delegate = self
        collectionView.dataSource = self
        setupButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    public func setupPresenter(presenter: ImageSliderPresenter) {
      self.presenter = presenter
    }
    
    private func setupButton() {
        pageControl.numberOfPages = presenter.images.count
        minimizeImageView.image = ImageProvider.minimize
        containerView.cornerRadius = 20
        containerView.applyBlurEffect(style: .regular)
        
        let minimizeGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped(sender:)))
        containerView.addGestureRecognizer(minimizeGestureRecognizer)
        containerView.isUserInteractionEnabled = true
    }
    
    @objc private func viewTapped(sender: UITapGestureRecognizer) {
        presenter.router.trigger(.dismiss, with: TransitionOptions(animated: true))
    }
}
extension ImageSliderController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
        pageControl.currentPage =  page
        
    }
}
