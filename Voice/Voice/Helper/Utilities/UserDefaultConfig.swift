//
//  UserDefaultConfig.swift
//  Voice
//
//  Created by Peide Xiao on 10/19/20.
//

import Foundation
import UIKit


@propertyWrapper
struct UserDefault<T: Codable> {
    
    var key: String
    var defaultValue: T
    
    init(_ key: String, _ defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            if let data = UserDefaults.standard.value(forKey: self.key) as? Data,
               let result = try? JSONDecoder().decode(T.self, from: data) {
                return result
            }
            return defaultValue
        }
        
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.setValue(data, forKey: key)
            }
        }
        
    }
}

//@UserDefault("", []) static var videos: [VideoModel]

struct UserDefaultConfig<T: Codable> {
    
   static func save(_ value:T, with key: String) {
        if let data = try? JSONEncoder().encode(value) {
            UserDefaults.standard.setValue(data, forKey: key)
        }
    }
    
   static func value(for key: String) -> T? {
        if let data = UserDefaults.standard.value(forKey: key) as? Data,
           let result = try? JSONDecoder().decode(T.self, from: data) {
            return result
        }
        return nil
    }
}
