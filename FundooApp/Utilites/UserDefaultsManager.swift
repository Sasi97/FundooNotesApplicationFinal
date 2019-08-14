//
//  UserDefaultsManager.swift
//  FundooApp
//
//  Created by BridgeLabz Solutions LLP  on 7/29/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import Foundation

class UserDefaultsManager {
    static let defaults = UserDefaults.standard
    static func setUser(value : Bool, key : String) {
        defaults.set(value, forKey: key)  
        defaults.synchronize()
    }
    static func isUserLogged(key : String) -> Bool{
        let value = defaults.bool(forKey: key)
        return value
    }
    static func setValue(value : Any , key : String) {
        defaults.set(value, forKey: key)
    }
    static func retreiveValue(key : String) -> Any {
        let value = defaults.value(forKey: key)
        return value
    }
    static func removeValues(key : String) {
        defaults.removeObject(forKey: "key")
    }
}
