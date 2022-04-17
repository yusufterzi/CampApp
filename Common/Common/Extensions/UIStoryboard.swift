//
//  UIStroyboard+Extensions.swift
//  CampApp
//
//  Created by Nurullah Vural on 26.02.2022.
//

import Foundation
import UIKit
public protocol Storyboarded {
    static func instantiate() -> Self
}

public extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
