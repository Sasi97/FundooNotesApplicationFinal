//
//  DatabaseManager.swift
//  FundooApp
//
//  Created by BridgeLabz Solutions LLP  on 7/10/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import Foundation
import SQLite3
let dbName = "FundooNotesDB.db"
let userTableName = "User"
let userId = "id"
let userFirstname = "firstName"
let userLastName = "lastName"
let userEmail = "email"
let userMobileNum = "mobileNumber"
let userPassword = "password"

class SqliteController {
 
    private static  var dbInstance:SqliteController?
    var SqlliteDB:OpaquePointer?

    private init(){
        openDB()
        createTable()
    }
    
    func openDB(){
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbName)
        if sqlite3_open(fileURL.path, &SqlliteDB) != SQLITE_OK {
            print("error opening database")
        }else {
            print("Database created or read at \(fileURL.path)")
        }
    }
    func createTable(){
        let createQuery = "CREATE TABLE IF NOT EXISTS \(userTableName) ( \(userId) INTEGER PRIMARY KEY AUTOINCREMENT, \(userFirstname) TEXT NOT NULL, \(userLastName) TEXT NOT NULL, \(userEmail) TEXT NOT NULL, \(userMobileNum) TEXT NOT NULL, \(userPassword) TEXT NOT NULL ) "
        if sqlite3_exec(SqlliteDB,createQuery,nil,nil,nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(SqlliteDB)!)
            print("error creating table: \(errmsg)")
        }else {
            print(" \(userTableName) Table Created ")
        }
    }
    private func closeDB() {
        if(SqlliteDB != nil){
            sqlite3_close(SqlliteDB)
            print(" \(dbName) Database closed")
        }
    }
    static func getInstance() -> SqliteController? {
        if(dbInstance == nil){
            dbInstance = SqliteController()
        }
        return dbInstance
    }
    func getDbInstance() -> OpaquePointer? {
        return SqlliteDB
    }
    deinit {
        closeDB()
    }
}
