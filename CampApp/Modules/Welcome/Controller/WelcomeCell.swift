//
//  WelcomeCell.swift
//  CampApp
//
//  Created by Nurullah Vural on 14.02.2022.
//

import UIKit

class WelcomeCell: UICollectionViewCell {
    
    static let identifier = String(describing: WelcomeCell.self)
    @IBOutlet private var imageView: UIImageView!
    
    func setup(_ slide: WelcomeData)  {
        imageView.image = slide.image
    }
    
}
