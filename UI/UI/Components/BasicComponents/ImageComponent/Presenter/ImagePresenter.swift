//
//  ImagePresenter.swift
//  YTUI
//
//  Created by yusuf terzi on 4.10.2021.
//

import UIKit
import FirebaseStorageUI

public class ImageViewModel {
    public var size: CGSize
    public var imageReference: StorageReference
    public var cornerRadius: CGFloat
    
    public init(size: CGSize, imageReference: StorageReference, cornerRadius: CGFloat) {
        self.size = size
        self.imageReference = imageReference
        self.cornerRadius = cornerRadius
    }
}

public protocol ImagePresenterProtocol {
    var item: ImageViewModel { get }
}

public final class ImagePresenter: ImagePresenterProtocol {
    
    public var item: ImageViewModel
    
    public init(item: ImageViewModel) {
        self.item = item
    }
}
