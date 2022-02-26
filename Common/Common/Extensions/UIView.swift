//
//  UIView.swift
//  Common
//
//  Created by Nurullah Vural on 26.02.2022.
//

import Foundation
import UIKit

public extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
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
    func applyBlurEffect(style: UIBlurEffect.Style) {
        self.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.clipsToBounds = true
        blurEffectView.layer.cornerRadius = 20
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.insertSubview(blurEffectView, at: 0)
    }
    
}
