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
    func cellForRow(at indexPath: IndexPath, to collectionView: UICollectionView) -> WelcomeCell
    var images: [WelcomeData] { get set }
}

final class WelcomePresenter: WelcomePresenterProtocol {
    public var images: [WelcomeData] = [
        WelcomeData(name : "Marmara", image: ImageProvider.onboarding),
        WelcomeData(name : "Ege", image: ImageProvider.onboarding),
        WelcomeData(name : "Karadeniz", image: ImageProvider.onboarding),
        WelcomeData(name : "Akdeniz", image: ImageProvider.onboarding)
    ]
    internal var router: UnownedRouter<MainRoute>
    
    init(router: UnownedRouter<MainRoute>) {
        self.router = router
    }
    
    public func loadUI() {
        
    }
    
    public func cellForRow(at indexPath: IndexPath, to collectionView: UICollectionView) -> WelcomeCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WelcomeCell.identifier, for: indexPath) as! WelcomeCell
        cell.setup(images[indexPath.item])
        return cell
    }
    
}




