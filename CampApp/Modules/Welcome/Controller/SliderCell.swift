//
//  SliderCell.swift
//  CampApp
//
//  Created by Nurullah Vural on 14.02.2022.
//

import UIKit

class SliderCell: UICollectionViewCell {
    
    static let identifier = String(describing: SliderCell.self)
    @IBOutlet private var imageView: UIImageView!
    
    func setup(_ slide: SliderData)  {
        imageView.image = slide.image
    }
    
}
