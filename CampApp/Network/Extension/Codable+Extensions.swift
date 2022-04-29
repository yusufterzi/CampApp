//
//  Codable+Extension.swift
//  Networking
//
//  Created by yusuf terzi on 5.08.2020.
//  Copyright © 2020 Raxar Corporation. All rights reserved.
//

import UIKit
import Common

public extension Encodable {
    func getParameters() -> [String: Any] {
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(AnyEncodable(self))
            let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? Parameters
            if let jsonValue = json {
                return jsonValue
            }
        } catch { }
        
        return [String: Any]()

    }
    
    func getParametersArray() -> [[String: Any]] {
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(AnyEncodable(self))
            let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [Parameters]
            if let jsonValue = json {
                return jsonValue
            }
        } catch { }
        
        return [[String: Any]]()

    }
}

extension Encodable {
    fileprivate func encode(to container: inout SingleValueEncodingContainer) throws {
        try container.encode(self)
    }
}

struct AnyEncodable: Encodable {
    var value: Encodable
    
    init(_ value: Encodable) {
        self.value = value
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try value.encode(to: &container)
    }
}
