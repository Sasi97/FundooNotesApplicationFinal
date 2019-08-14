//
//  CoreDataNoteHelper.swift
//  FundooApp
//
//  Created by BridgeLabz Solutions LLP  on 8/8/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class CoreDataNoteHelper{
    var appDel:AppDelegate!
    var entityDescription:NSEntityDescription!
    var managedObjectContext:NSManagedObjectContext!
  
    
    func saveNote(note:NoteModel)  {
        appDel = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext =  appDel!.persistentContainer.viewContext;
       entityDescription = NSEntityDescription.entity(forEntityName: "Notes", in: managedObjectContext)
        let noteObj=NSManagedObject(entity: entityDescription, insertInto: managedObjectContext)
        noteObj.setValue(note.title, forKey: Keys.title.rawValue)
        noteObj.setValue(note.description, forKey: Keys.description.rawValue)
        noteObj.setValue(note.id, forKey: Keys.noteId.rawValue)
        noteObj.setValue(note.color, forKey: Keys.color.rawValue)
        noteObj.setValue(note.isPined, forKey: Keys.pinned.rawValue)
        noteObj.setValue(note.isArchived, forKey: Keys.archived.rawValue)
        noteObj.setValue(note.reminder, forKey: Keys.remainder.rawValue)
        noteObj.setValue(note.isDeleted, forKey: Keys.trashed.rawValue)
        do{
            try managedObjectContext.save()
            print(noteObj)
            print("DONE NOTE SAVED TO COREDATA")
        }catch{
            print("ERROR SAVING TO COREDATA")
        }
        
        // deleteAllNotes()
    }
    func deleteAllNotes(){
        appDel = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext =  appDel!.persistentContainer.viewContext;
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedObjectContext.execute(batchDeleteRequest)
            print("Deleted all objects from coredata")
            
        } catch {
            print("Error deleting all data from coredata")
        }
    }
    func fetchLocalNotes(fetchOffSet : Int) -> [NoteModel]{
        appDel = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext =  appDel!.persistentContainer.viewContext;
        var listOfNotes = [NoteModel]()
        let fetchedRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        fetchedRequest.fetchLimit = 5
        fetchedRequest.fetchOffset = fetchOffSet
        do{
            let listOfDBNotes = try managedObjectContext.fetch(fetchedRequest) as! [NSManagedObject]
            for dbNote in listOfDBNotes {
                let noteId = dbNote.value(forKey: Keys.noteId.rawValue) as! String
                let noteTitle = dbNote.value(forKey: Keys.title.rawValue) as! String
                let noteDesc = dbNote.value(forKey: Keys.description.rawValue) as! String
                let noteColor = dbNote.value(forKey: Keys.color.rawValue) as! String
                let noteIsPinned = dbNote.value(forKey: Keys.pinned.rawValue) as! Bool
                let noteIsArchived = dbNote.value(forKey: Keys.archived.rawValue) as! Bool
                let noteRemainder = dbNote.value(forKey: Keys.remainder.rawValue) as! String
                let noteTrashed = dbNote.value(forKey: Keys.trashed.rawValue) as! Bool
                let foundNote = NoteModel(id: noteId, title: noteTitle, description: noteDesc, isArchived: noteIsArchived, isPined: noteIsPinned, color: noteColor, reminder: noteRemainder, isDeleted: noteTrashed)
                print(foundNote)
                listOfNotes.append(foundNote)
            }
        }catch let error{
            print("ERROR IN FETCHING : \(error.localizedDescription)")
        }
        return listOfNotes
    }
    
}
extension CoreDataNoteHelper {
    enum Keys:String {
        case title = "noteTitle"
        case description = "noteDesc"
        case noteId = "noteId"
        case color = "noteColor"
        case pinned = "isPined"
        case archived = "isArchived"
        case remainder = "noteRemainder"
        case trashed = "isDelete"
    }
    
}
