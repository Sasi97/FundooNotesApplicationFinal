//
//  NoteModel.swift
//  FundooApp
//
//  Created by BridgeLabz Solutions LLP  on 7/23/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import Foundation

class NoteModel : Codable {
    var id : String?
    var title : String
    var description : String
    var isArchived : Bool
    var isPined : Bool
    var isDeleted : Bool
    var color : String
    var reminder : String
    init(title : String, description : String, isArchived : Bool, isPined : Bool, color : String, reminder : String, isDeleted : Bool) {
        self.title = title
        self.description = description
        self.isArchived = isArchived
        self.isPined = isPined
        self.color = color
        self.reminder = reminder
        self.isDeleted = isDeleted
    }
    init(id: String,title : String, description : String, isArchived : Bool, isPined : Bool, color : String, reminder : String, isDeleted : Bool) {
        self.id = id
        self.title = title
        self.description = description
        self.isArchived = isArchived
        self.isPined = isPined
        self.color = color
        self.reminder = reminder
        self.isDeleted = isDeleted
    }
    init(from dict : [String : AnyObject]) {
        self.id = dict["id"] as? String
        self.title = dict["title"] as! String
        self.description = dict["description"] as! String
        self.isArchived = dict["isArchived"] as! Bool
        self.isPined = dict["isPined"] as! Bool
        self.color = dict["color"] as! String
        self.isDeleted = dict["isDeleted"] as! Bool
        let reminderDict = dict["reminder"] as! [String]
        self.reminder = !reminderDict.isEmpty ? reminderDict[0] : ""
    }
    
   
    
}
