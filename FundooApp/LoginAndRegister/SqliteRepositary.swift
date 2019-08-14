//
//  DatabaseRepositary.swift
//  FundooApp
//
//  Created by BridgeLabz Solutions LLP  on 7/10/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import Foundation
import SQLite3

class SqliteRepositary {
    
    private var sqliteDb : SqliteController?
    private var dbInstance : OpaquePointer?
    private var statement : OpaquePointer?
    init(){
        sqliteDb = SqliteController.getInstance()
        dbInstance = sqliteDb?.getDbInstance()
    }
   
    func insert(with user: User) -> Bool {
        
        let insertQuery = """
        INSERT INTO \(userTableName)
        ( \(userFirstname) , \(userLastName), \(userEmail), \(userMobileNum), \(userPassword)
        )
        VALUES ( '\(user.firstName)', '\(user.lastName)', '\(user.email)', '\(user.mobileNumber)', '\(user.password)'
        )
        """
        
        if sqlite3_prepare(dbInstance, insertQuery, -1, &statement, nil) != SQLITE_OK {
            print("error in inserting data ")
        }else {
            print("\(user) inserted into Database")
        }
        
        let isInserted = sqlite3_step(statement) == SQLITE_DONE
        sqlite3_finalize(statement)
        print("\(getUsers())")
        return isInserted
    }
    func getUsers() -> [User]{
        var userList=[User]()
        userList.removeAll()
        var statement:OpaquePointer?
        let retreiveQuery = "SELECT * FROM \(userTableName)"
        if sqlite3_prepare(dbInstance, retreiveQuery, -1, &statement, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(dbInstance)!)
            print("error preparing insert: \(errmsg)")
        }
        while(sqlite3_step(statement) == SQLITE_ROW){
            let id = sqlite3_column_int(statement, 0)
            let firstName = String(cString: sqlite3_column_text(statement, 1))
            let lastName = String(cString: sqlite3_column_text(statement, 2))
            let email = String(cString: sqlite3_column_text(statement, 3))
            let mobileNum = String(cString: sqlite3_column_text(statement, 4))
            let password = String(cString: sqlite3_column_text(statement, 5))
            userList.append(User(id: Int(id), firstName: firstName, lastName: lastName, email: email, mobileNum: mobileNum, password: password))
        }
        return userList
    }
    
   
}







//    func  isEmailExists(credentials: Dictionary<String, String>) -> Bool {
//        var statement:OpaquePointer?
//        var dbEmail:String?
//        let retreiveQuery = "SELECT * FROM \(userTableName) WHERE email = \(credentials["email"]!)"
//        if sqlite3_prepare(dbInstance, retreiveQuery, -1, &statement, nil) != SQLITE_OK{
//            let errmsg = String(cString: sqlite3_errmsg(dbInstance)!)
//            print("error preparing insert: \(errmsg)")
//        }
//
//        if(sqlite3_step(statement) == SQLITE_ROW) {
//             dbEmail = String(cString: sqlite3_column_text(statement, 3))
//        }
//       if credentials["email"] == dbEmail {
//           return true
//        } else {
//            return false
//        }
//    }
