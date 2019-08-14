//
//  KeyChainAccess.swift
//  FundooApp
//
//  Created by BridgeLabz Solutions LLP  on 7/28/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import Foundation
import KeychainAccess
class KeyChainManager {
 
    static func setValue(service : String, key : String , value : String) {
        
        do {
            let keyChain = Keychain(service: service)
            try keyChain.set(value, key: key)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    static func getValue(service : String, key : String) -> String {
        var  retreivedString = String()
        do {
            let keyChain = Keychain(service: service)
            try retreivedString = keyChain.get(key)!
        } catch let error {
            print(error.localizedDescription)
        }
        return retreivedString
    }
    static func removeValues(service : String) {
        do {
            let keyChain = Keychain(service: service)
            try keyChain.removeAll()
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
}
