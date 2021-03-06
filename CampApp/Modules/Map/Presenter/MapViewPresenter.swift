//
//  MapViewPresenter.swift
//  CampApp
//
//  Created by Nurullah Vural on 8.03.2022.
//
import XCoordinator
import Carbon
import Common
import YTUI
import YTNetwork
import AttributedStringBuilder
import UIKit

protocol MapViewPresenterProtocol {
    
}

final class MapViewPresenter: MapViewPresenterProtocol {
    
    internal var router: UnownedRouter<CampDetailRoute>
    
    
    init(router: UnownedRouter<CampDetailRoute>) {
        self.router = router
    }
    
    
    public func loadUI(viewController: ImageSliderController) {
        
        
    }

}
