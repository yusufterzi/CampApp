//
//  CampAreaCollectionPresenter.swift
//  YTUI
//
//  Created by Nurullah Vural on 4.03.2022.
//


import Foundation
import YTNetwork
import Carbon
import Common

public protocol CampAreaCollectionPresenterProtocol {
    var sections: [Section] { get }

}

public final class CampAreaCollectionPresenter: CampAreaCollectionPresenterProtocol {
    
    public init() {
    }
    
    public var sections: [Section] {
        var cells: [CellNode] = .init()
        let presenter = CampAreaImageItemPresenter(image: nil, addImage: ImageProvider.addButton, removeImage: nil, text: nil)
        cells.append(CellNode(CampAreaImageItemComponent(id: "", presenter: presenter)))
        let section = Section(id: "", header: nil, cells: cells, footer: nil)
        return [section]
    }
}
