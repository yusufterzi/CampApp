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
  var reloadData: VoidHandler? { get set }
  var selectedImages: [UIImage] { get set }
  var selectedImagesHandler: Handler<[UIImage]>? { get set }
  var introductionImageIndex: Int { get set }
  var introImageIndexHandler: Handler<Int>? { get set }

}

public final class CampAreaCollectionPresenter: CampAreaCollectionPresenterProtocol {
  public var selectedImagesHandler: Handler<[UIImage]>?
  public var removeImageHandler: Handler<UIImage>?
  public var reloadData: VoidHandler?
  public var introImageIndexHandler: Handler<Int>?

  public var selectedImages: [UIImage] = [UIImage]() {
    didSet {
      setupSections()
      reloadData?()
    }
  }
  
  public var sections: [Section] = .init()
  var cells: [CellNode] = .init()
  public var introductionImageIndex: Int = 0

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
    for (index, image) in self.selectedImages.enumerated() {
      let presenterCamp = CampAreaImageItemPresenter(image: image, addImage: nil, removeImage: ImageProvider.removeButton, text : index == introductionImageIndex ? "KAPAK" : nil)
      presenterCamp.removeImageHandler = { [weak self] image in
        if let index = self?.selectedImages.firstIndex(of: image) {
          self?.handleIntroductionImageIndex(index)
          self?.selectedImages.remove(at: index)
        }
      }
      presenterCamp.longPressHandler = { [weak self] in
        self?.introductionImageIndex = index
        self?.introImageIndexHandler?(self?.introductionImageIndex ?? 0)
        self?.setupSections()
        self?.reloadData?()
      }
      
      cells.append(CellNode(CampAreaImageItemComponent(id: "CampImage\(index)", presenter: presenterCamp)))
    }
    cells.append(CellNode(CampAreaImageItemComponent(id: "AddButton", presenter: presenter)))
    
    let section = Section(id: "CampAreaItem", header: nil, cells: cells, footer: nil)
    sections = [section]
  }
  private func handleIntroductionImageIndex(_ index: Int) {
    
    if index == introductionImageIndex {
      self.introductionImageIndex = 0
    }
    
    if index < introductionImageIndex {
      self.introductionImageIndex -= 1
    }
  }
}
