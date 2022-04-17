//
//  NSAttributedString+Extensions.swift
//  CampApp
//
//  Created by Nurullah Vural on 26.02.2022.
//

import Foundation

public extension NSAttributedString {
    
    func append(to: NSAttributedString) -> NSMutableAttributedString {
        let result = NSMutableAttributedString()
        result.append(self)
        result.append(to)
        return result
    }

}
