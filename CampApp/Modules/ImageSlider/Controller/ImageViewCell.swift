//
//  ImageViewCell.swift
//  CampApp
//
//  Created by Nurullah Vural on 21.02.2022.
//

import UIKit
import SDWebImage

class ImageViewCell: UICollectionViewCell {
    static let identifier = String(describing: ImageViewCell.self)
    @IBOutlet var imageView: UIImageView!
    func setup(_ image: String)  {
        imageView.sd_setImage(with: URL(string: image))
    }
}
