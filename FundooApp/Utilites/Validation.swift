//
//  Validation.swift
//  FundooApp
//
//  Created by BridgeLabz Solutions LLP  on 7/10/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import Foundation
public class Validation{
    static func isEmailValid(email:String)->Bool{
        
        let regex="[A-Za-z0-9.@%#!-]+@[A-Za-z0-9.-]+.[A-Za-z0-9]{2,3}"
        let test = NSPredicate(format:"SELF MATCHES %@", regex)
        return test.evaluate(with: email)
    }
    static func isPasswordValid(password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "[A-Za-z0-9\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    static func isPhnNumValid(number: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}\\d{3}\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: number)
        return result
    }
    
}
