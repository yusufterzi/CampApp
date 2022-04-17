//
//  ImageViewCell.swift
//  CampApp
//
//  Created by Nurullah Vural on 21.02.2022.
//

import UIKit
import SDWebImage
import FirebaseUI

final class ImageViewCell: UICollectionViewCell {
    static let identifier = String(describing: ImageViewCell.self)
    @IBOutlet private var imageView: UIImageView!
    func setup(_ image: StorageReference)  {
        imageView.sd_setImage(with: image)
    }
}
