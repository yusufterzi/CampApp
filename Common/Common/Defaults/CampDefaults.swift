//
//  CampDefaults.swift
//  Common
//
//  Created by Nurullah Vural on 13.02.2022.
//

import Foundation


private var campDefaultsShared: CampDefaults!

public enum PersistentDomain: String {
    case test
    case production
}

public class CampDefaults {
    
    private var config: PersistentDomain!
    private let defaults: UserDefaults!
    
    public class func setup(with config: PersistentDomain) {
        campDefaultsShared = CampDefaults(config: config)
    }
    
    public class var shared: CampDefaults {
        if campDefaultsShared == nil {
        }
        return campDefaultsShared
    }
    
    init(config: PersistentDomain) {
        self.config = config
        defaults = UserDefaults(suiteName: config.rawValue)
    }
    
    // MARK: - Public Helper Methods
    public func store<T>(with key: CampDefaultsKey, value: T) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    public func storeInt(with key: CampDefaultsKey, value: Int) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    public func storeFlag(with key: CampDefaultsKey, value: Bool) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    public func retrieve<T>(with key: CampDefaultsKey) -> T? {
        return defaults.object(forKey: key.rawValue) as? T
    }
    
    public func retrieveInt(with key: CampDefaultsKey) -> Int? {
        return defaults.integer(forKey: key.rawValue)
    }
    
    public func setStruct<T: Codable>(_ value: T?, forKey key: CampDefaultsKey) {
        let data = try? JSONEncoder().encode(value)
        defaults.set(data, forKey: key.rawValue)
    }
    
    public func structData<T>(_ type: T.Type, forKey key: CampDefaultsKey) -> T? where T: Decodable {
        guard let encodedData = defaults.data(forKey: key.rawValue) else {
            return nil
        }
        
        return try! JSONDecoder().decode(type, from: encodedData)
    }
    
    public func setStructArray<T: Codable>(_ value: [T], forKey key: CampDefaultsKey) {
        let data = value.map { try? JSONEncoder().encode($0) }
        
        defaults.set(data, forKey: key.rawValue)
    }
    
    public func structArrayData<T>(_ type: T.Type, forKey key: CampDefaultsKey) -> [T] where T: Decodable {
        guard let encodedData = defaults.array(forKey: key.rawValue) as? [Data] else {
            return []
        }
        
        return encodedData.map { try! JSONDecoder().decode(type, from: $0) }
    }
    
    public func clearAll() {
        defaults.removePersistentDomain(forName: config.rawValue)
        defaults.synchronize()
    }
}
