//
//  ProfileInteractor.swift
//  CampApp
//
//  Created by Nurullah Vural on 28.02.2022.
//


import Foundation
import YTUI
import YTNetwork
import Common

protocol ProfileInteractorProtocol: BaseInteractor {
    func loadProfileData()
    var  profileLoadHandler: VoidHandler? { get set }
    
}

final class ProfileInteractor: ProfileInteractorProtocol {
    
    public func getItems() {}
    var profileLoadHandler: VoidHandler?

    public func loadProfileData() {
        self.profileLoadHandler?()
    }
}
