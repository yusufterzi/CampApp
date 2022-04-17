//
//  CampAddingInteractor.swift
//  CampApp
//
//  Created by Nurullah Vural on 2.03.2022.
//


import Foundation
import YTUI
import YTNetwork
import Common

protocol CampAddingInteractorProtocol: BaseInteractor {
    func uploadData()
    var  uploadHandler: VoidHandler? { get set }
    var camp: CampModel { get set }
    var campImages: [CampImageModel] { get set }
}

final class CampAddingInteractor: CampAddingInteractorProtocol {
    var camp: CampModel = .init()
    var campImages: [CampImageModel] = .init()
    
    public func getItems() {}
    var uploadHandler: VoidHandler?
    
    public func uploadData() {
        saveCamp(camp: self.camp)
    }
    private func saveCamp(camp: CampModel?) {
        FirebaseNetwork.shared?.addCamp(data: camp) { [weak self] response in
            if let success = response.value, success {
                self?.saveCampImages(images: self?.campImages)
            }
        }
    }
    
    private func saveCampImages(images: [CampImageModel]?) {
        FirebaseNetwork.shared?.uploadCampImage(images: images) { [weak self] response in
            if let response = response.value , response {
                self?.uploadHandler?()
            }
        }
    }
}
