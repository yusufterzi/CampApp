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
  var viewTranslation = CGPoint(x: 0, y: 0)

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
    view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))
    
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
    containerView.applyBlurEffect(style: .regular, cornerRadius: 20)
    
    let minimizeGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped(sender:)))
    containerView.addGestureRecognizer(minimizeGestureRecognizer)
    containerView.isUserInteractionEnabled = true
  }
  
  @objc private func viewTapped(sender: UITapGestureRecognizer) {
    presenter.router.trigger(.dismiss, with: TransitionOptions(animated: true))
  }
  @objc func handleDismiss(sender: UIPanGestureRecognizer) {
      switch sender.state {
      case .changed:
          viewTranslation = sender.translation(in: view)
          UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
          })
      case .ended:
          if viewTranslation.y < 150 {
              UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                  self.view.transform = .identity
              })
          } else {
              dismiss(animated: true, completion: nil)
          }
      default:
          break
      }
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
