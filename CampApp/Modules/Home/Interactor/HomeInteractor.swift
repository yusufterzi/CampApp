//
//  HomeInteractor.swift
//  CampApp
//
//  Created by yusuf terzi on 28.09.2021.
//

import Foundation
import YTUI
import YTNetwork
import Common

protocol HomeInteractorProtocol: BaseInteractor {
    
    func loadData(campSegment: HomeSegmentEnum)
    var camps: [CampModel] { get set }
    var campImages: [CampImageModel] { get set }
    var areas: [CampAreaModel] { get set }
    
    var loadHandler: VoidHandler? { get set }
}

final class HomeInteractor: HomeInteractorProtocol {
    
    func getItems() { }
    
    var loadHandler: VoidHandler?
    var camps: [CampModel] = .init()
    var areas: [CampAreaModel] = .init()
    var campImages: [CampImageModel] = .init()

    
    func loadData(campSegment: HomeSegmentEnum) {
        getCamps(campSegment: campSegment)
    }
    
    private func getCamps(campSegment: HomeSegmentEnum) {
        FirebaseNetwork.shared?.allCamps(campSegment: campSegment) { [weak self] response in
            if let data = response.value {
                self?.camps = data
                self?.getCampAreas()
            }
        }
    }
    
    private func getCampAreas() {
        FirebaseNetwork.shared?.allCampAreas { [weak self] response in
            if let data = response.value {
                self?.areas = data
                self?.loadHandler?()
            }
        }
    }    
}
