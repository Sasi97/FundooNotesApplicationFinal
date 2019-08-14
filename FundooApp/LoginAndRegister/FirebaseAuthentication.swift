////
////  FirebaseAuthentication.swift
////  FundooApp
////
////  Created by BridgeLabz Solutions LLP  on 7/14/19.
////  Copyright © 2019 Apple Inc. All rights reserved.
////
//
//import Foundation
//import Firebase
//import FirebaseAuth
//class FirebaseAuthentication {
//
//     let authenticate = Auth.auth()
//     func firebaseSignUp(email:String , password: String){
//        authenticate.createUser(withEmail: email, password: password) { (user, error) in
//            if user != nil {
//                print(user!)
//            } else {
//                print( error?.localizedDescription ?? "")
//            }
//        }
//    }
//    func firebaseSignIn(email: String,password :String){
//        authenticate.signIn(withEmail: email, password: password) { (user, error) in
//            if user != nil {
//                print("FireBase Authenticated")
//            }else {
//                print(error?.localizedDescription ?? "")
//            }
//        }
//    }
//}
