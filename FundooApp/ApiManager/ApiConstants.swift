//
//  ApiUtilities.swift
//  FundooApp
//
//  Created by BridgeLabz Solutions LLP  on 7/23/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import Foundation
var baseUrl = "http://34.213.106.173/api/"
enum HttpMethods : String {
    case Get = "GET"
    case Post = "POST"
    case Delete = "DELETE"
    case Put = "PUT"
}
enum PathVariables : String {
    case addNote  = "notes/addNotes"
    case updateNote = "notes/updateNotes"
    case getNotes = "notes/getNotesList"
    case getArchiveNotes = "notes/getArchiveNotesList"
    case pinUnpinNotes = "notes/pinUnpinNotes"
    case archiveNotes = "notes/archiveNotes"
    case updateRemainder = "notes/addUpdateReminderNotes"
    case changeColor = "notes/changesColorNotes"
    case removeReminder = "notes/removeReminderNotes"
    case trashNotes = "notes/trashNotes"
    case getRemainderNotes = "notes/getReminderNotesList"
    case getTrashNotes = "notes/getTrashNotesList"
    case uploadProfilePic = "user/uploadProfileImage"
}
