//
//  UIView+Extensions.swift
//  CampApp
//
//  Created by Nurullah Vural on 14.02.2022.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }

}
