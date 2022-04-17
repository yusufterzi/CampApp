//
//  UIView.swift
//  YTUI
//
//  Created by Nurullah Vural on 20.02.2022.
//

import Foundation
import UIKit

extension UIView {
    
    func addCircleShadow() {
        
        let roundedShapeLayer = CAShapeLayer()        
        roundedShapeLayer.fillColor = UIColor.white.cgColor
        roundedShapeLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 18).cgPath
        
        self.layer.insertSublayer(roundedShapeLayer, at: 0)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.cornerRadius = 18
    }
}
