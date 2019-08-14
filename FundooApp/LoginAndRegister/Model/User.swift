//
//  UserModel.swift
//  FundooApp
//
//  Created by BridgeLabz Solutions LLP  on 7/10/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import Foundation

struct User:Codable {
    var Id : Int
    var firstName : String
    var lastName : String
    var email : String
    var mobileNumber : String
    var password : String
    init(id:Int,firstName:String,lastName:String,email:String,mobileNum:String,password:String) {
        self.Id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.mobileNumber = mobileNum
        self.password = password
    }
    func asDict() -> [String : String] {
        let dict = ["firstName" : self.firstName,
                    "lastName" : self.lastName,
                    "email" : self.email,
                    "mobileNumber" : self.mobileNumber,
                    "service": "advance",
                    "role":"user",
                    "password": self.password]
        return dict
    }
   
}
