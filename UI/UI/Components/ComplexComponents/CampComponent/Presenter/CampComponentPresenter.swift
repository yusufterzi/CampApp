//
//  CampComponentPresenter.swift
//  CampApp
//
//  Created by yusuf terzi on 24.09.2021.
//

import Foundation
import YTNetwork
import Common
import FirebaseUI

public class CampComponentViewModel {
    public var name: String?
    public var subLocation: String?
    public var city: String?
    public var description: String?
    public var imageReference: [StorageReference]?
    public var latitude: Double?
    public var longitude: Double?
    public var point: Double?
    public var address: String?
    public var id: String
    
    public init(name: String? = nil, subLocation: String? = nil , city: String? = nil, description: String? = nil, imageReference: [StorageReference]? = nil, latitude: Double? = nil, longitude: Double? = nil, point: Double? = nil, address: String? = nil, id: String) {
        
        self.name = name
        self.subLocation = subLocation
        self.city = city
        self.description = description
        self.imageReference = imageReference
        self.latitude = latitude
        self.longitude = longitude
        self.point = point
        self.address = address
        self.id = id
    }
}

public protocol CampComponentPresenterProtocol {
    var point: String { get }
    var location: String { get }
    var image: StorageReference { get }
    var name: String { get }
    var onTap: VoidHandler? { get set }
}

public final class CampComponentPresenter: CampComponentPresenterProtocol {
    public var onTap: VoidHandler?
    private var item: CampComponentViewModel
    
    public var point: String {
        String(format: "%.1f", item.point ?? 0)
    }
    
    public var location: String {
        (item.subLocation ?? "") + "/" + (item.city ?? "")
    }
    
    public var image: StorageReference {
        item.imageReference?.first ?? Storage.storage().reference()
    }
    
    public init(item: CampComponentViewModel) {
        self.item = item
    }
    
    public var name: String {
        item.name ?? ""
    }
}
