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
    var removeImageHandler: Handler<UIImage>? { get set}
    var reloadData: VoidHandler? { get set }
}

public final class CampAreaCollectionPresenter: CampAreaCollectionPresenterProtocol {
    public var removeImageHandler: Handler<UIImage>?
    public var reloadData: VoidHandler?
    public var selectedImages: [UIImage] = [UIImage]() {
        didSet {
            setupSections()
            reloadData?()
        }
    }
    public var sections: [Section] = .init()
    var cells: [CellNode] = .init()
    
    public init() {
        setupSections()
    }
    
    private func setupSections() {
        cells.removeAll()
        sections.removeAll()
        let presenter = CampAreaImageItemPresenter(image: nil, addImage: ImageProvider.addButton, removeImage: nil, text: nil)
        presenter.addImageHandler = { [weak self] image in
            self?.selectedImages.append(image)
        }        
        cells.append(CellNode(CampAreaImageItemComponent(id: "AddButton", presenter: presenter)))

        for (index, image) in self.selectedImages.enumerated() {
            let presenterCamp = CampAreaImageItemPresenter(image: image, addImage: nil, removeImage: ImageProvider.removeButton, text: nil)
            cells.append(CellNode(CampAreaImageItemComponent(id: "CampImage\(index)", presenter: presenterCamp)))
        }
        
        let section = Section(id: "CampAreaItem", header: nil, cells: cells, footer: nil)
        sections = [section]
    }
}
