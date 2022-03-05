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
    
}

final class CampAddingInteractor: CampAddingInteractorProtocol {
    
    public func getItems() {}
    var uploadHandler: VoidHandler?

    public func uploadData() {
        self.uploadHandler?()
    }
}
