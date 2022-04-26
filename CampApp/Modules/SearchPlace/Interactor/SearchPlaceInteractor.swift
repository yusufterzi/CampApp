//
//  SearchPlaceInteractor.swift
//  CampApp
//
//  Created by yusuf terzi on 21.04.2022.
//

import Foundation
import YTUI
import YTNetwork
import Common
import GooglePlaces

protocol SearchPlaceInteractorProtocol: BaseInteractor {
    
    func loadData()
    
    var loadHandler: VoidHandler? { get set }
}

final class SearchPlaceInteractor: SearchPlaceInteractorProtocol {
    
    func getItems() {
      
      let placesClient = GMSPlacesClient.shared()
      
    }
    
    var loadHandler: VoidHandler?
    
    func loadData() {
        
    }
}
