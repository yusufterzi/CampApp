//
//  NSAttributedString+Extensions.swift
//  CampApp
//
//  Created by Nurullah Vural on 14.02.2022.
//

import Foundation

extension NSAttributedString {
    
    func append(to: NSAttributedString) -> NSMutableAttributedString {
        let result = NSMutableAttributedString()
        result.append(self)
        result.append(to)
        return result
    }

}
