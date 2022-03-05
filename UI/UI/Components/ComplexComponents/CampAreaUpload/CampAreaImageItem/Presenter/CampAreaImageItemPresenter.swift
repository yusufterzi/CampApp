//
//  CampAreaImageItemPresenter.swift
//  YTUI
//
//  Created by Nurullah Vural on 4.03.2022.
//

import Foundation
import Common
import AttributedStringBuilder

public protocol CampAreaImageItemPresenterProtocol {
    var image: UIImage? { get set }
    var addImage: UIImage? { get set }
    var removeImage: UIImage? { get set }
    var text: String? { get set }
}

public final class CampAreaImageItemPresenter: CampAreaImageItemPresenterProtocol {
    public var image: UIImage?
    public var addImage: UIImage?
    public var removeImage: UIImage?
    public var text: String?
    
    public init(image: UIImage?, addImage: UIImage?, removeImage: UIImage?, text: String?) {
        self.image = image
        self.addImage = addImage
        self.removeImage = removeImage
        self.text = text
    }
}
