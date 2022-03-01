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
    func cellForRow(at indexPath: IndexPath, to collectionView: UICollectionView) -> ImageViewCell
    
}

final class ImageSliderPresenter: ImageSliderPresenterProtocol {
    internal var router: UnownedRouter<HomeRoute>
    public var currentPage = 0
    public var images: [String]
    
    func cellForRow(at indexPath: IndexPath, to collectionView : UICollectionView) -> ImageViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageViewCell.identifier, for: indexPath) as! ImageViewCell
        cell.setup(images[indexPath.item])
        return cell
    }
    
  
    
    init(router: UnownedRouter<HomeRoute>, images: [String]) {
        self.router = router
        self.images = images
    }
    
    public func loadUI() {
        
    }
    
}




