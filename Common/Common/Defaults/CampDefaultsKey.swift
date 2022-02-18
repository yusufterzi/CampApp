//
//  CampDefaultsKey.swift
//  Common
//
//  Created by Nurullah Vural on 13.02.2022.
//

import UIKit

public enum CampDefaultsKey {
    case appFirstLaunch
    case onboardingAreaSelection
    case onboardingCampSelection
    
    case string(value: String)
}

extension CampDefaultsKey: RawRepresentable {
    
    public typealias RawValue = String
    
    public init?(rawValue: String) {
        fatalError("this enum should not be initialized.")
    }
    
    public var rawValue: String {
        switch self {
        case .string(let value):
            return value
        default:
            return String(describing: self)
        }
    }
    
}
