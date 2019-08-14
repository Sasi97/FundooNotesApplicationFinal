//
//  AddEditNotesVC.swift
//  FundooApp
//
//  Created by BridgeLabz Solutions LLP  on 7/15/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit
import MaterialComponents
import UserNotifications

class AddEditNotesVC: UIViewController {
    
    
    @IBOutlet weak var navigationView: MDCCard!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var titleTxtFld: UITextField!
    @IBOutlet weak var archiveBtn: UIButton!
    @IBOutlet weak var remainderTxtfld: UITextField!
    @IBOutlet weak var remainderBtn: UIButton!
    @IBOutlet weak var pinBtn: UIButton!
    @IBOutlet weak var bottomTabView: UIView!
    @IBOutlet weak var slideUpMenuConstr: NSLayoutConstraint!
    var noteManager = NotesApiManager()
    var isSilideUpMenu = false
    var isPinned = false
    var isArchived = false
    var isDeleted = false
    var color = "FFFFFF"
    var isEditable = false
    var datePicker:UIDatePicker!
    var noteToEdit:NoteModel?
    var index:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        setDatePicker()
        bindingData()
        addObserver()
        setPinImage()
       
    }
    private func setPinImage(){
        isPinned = noteToEdit?.isPined ?? false
        if isPinned {
            pinBtn.setImage(#imageLiteral(resourceName: "fillpin (1)"), for: .normal)
        } else {
            pinBtn.setImage(#imageLiteral(resourceName: "pin"), for: .normal)
        }
    }
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(colorReceiver(notification:)), name: NSNotification.Name("colorNotes"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteNote(notification:)), name: NSNotification.Name("DeleteNote"), object: nil)
    }
    @objc func colorReceiver(notification : NSNotification) {
        color = notification.userInfo!["color"] as! String
        if isEditable {
            var colorDict = [String : Any]()
            colorDict["color"] = "#" + color
            colorDict["noteIdList"] = [noteToEdit?.id] as! [String]
            noteManager.updateNotes(updateDict: colorDict, pathVariable: PathVariables.changeColor.rawValue)
            noteManager.getNotes(pathVariable: PathVariables.getNotes.rawValue)

            setColor(color: color)
        } else {
            setColor(color: color)
        }
        
    }
    @objc func deleteNote(notification : NSNotification) {
        if isEditable {
            var deleteDict = [String : Any]()
            deleteDict["isDeleted"] = true
            deleteDict["noteIdList"] = [noteToEdit?.id] as! [String]
            noteManager.updateNotes(updateDict: deleteDict, pathVariable: PathVariables.trashNotes.rawValue)
            noteManager.getNotes(pathVariable: PathVariables.getNotes.rawValue)
        }
        self.dismiss(animated: true, completion: nil)

    }
    private func bindingData()  {
        
        descriptionTextView.text = noteToEdit?.description ?? ""
        titleTxtFld.text = noteToEdit?.title ?? ""
        if isEditable {
            view.backgroundColor = UIColor.init(hex: noteToEdit?.color ?? "")
            if isPinned {
                pinBtn.setImage(#imageLiteral(resourceName: "fillpin (1)"), for: .normal)
            }
        } else {
            view.backgroundColor = UIColor.white
        }
        
    }
    
    private func setDatePicker()
    {
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(dateValueChanged(datePicker:)), for: .valueChanged)
        remainderTxtfld.inputView = datePicker
    }
    @objc func dateValueChanged(datePicker: UIDatePicker){
        
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .full
        dateFormat.timeStyle = .full
        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZ"
        remainderTxtfld.text = dateFormat.string(from: datePicker.date)
        datePicker.endEditing(true)
        
    }
    private func registerNotification(date: Date) {
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("permission granted")
            } else {
                print("permission not granted")
            }
            
            guard let error = error  else { return }
            print(error.localizedDescription)
        }
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "You added remainder to the Notes \(noteToEdit?.title ?? "")"
        content.sound = .default
        let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request) { error in
            
            guard let error = error else { return }
            print(error.localizedDescription)
            
        }
    }

    func setColor(color : String) {
        view.backgroundColor = UIColor.init(hex: color)
        navigationView.backgroundColor = UIColor.init(hex: color)
        descriptionTextView.backgroundColor = UIColor.init(hex: color)
        bottomTabView.backgroundColor = UIColor.init(hex: color)
    }
    func slideUpMenuSetup() {
        slideUpMenuConstr.constant = -195

        if isSilideUpMenu {
            isSilideUpMenu = false
            slideUpMenuConstr.constant = 0
        } else {
            isSilideUpMenu = true
            slideUpMenuConstr.constant = -195
        }
        UIView.animate(withDuration:0.3){
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        guard let title = titleTxtFld.text, let description = descriptionTextView.text, let remainder = remainderTxtfld.text else { return  }
        let note:NoteModel = NoteModel(title: title , description: description, isArchived: isArchived, isPined: isPinned, color: "#" + color, reminder: remainder, isDeleted: isDeleted)
        if isEditable {
            let dict = ["noteId" : noteToEdit!.id, "title" : title, "description" : description]
            noteManager.updateNotes(updateDict: dict as [String : Any]
                , pathVariable: PathVariables.updateNote.rawValue)
//            noteManager.getNotes(pathVariable: PathVariables.getNotes.rawValue)
            
        } else {
            noteManager.addNotes(note: note, pathVariable: PathVariables.addNote.rawValue)
        }
//        noteManager.getNotes(pathVariable: PathVariables.getNotes.rawValue)
        self.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func onClickPin(_ sender: UIButton) {
        if isEditable {
            var pinDict  = [String : Any]()
            isPinned = !isPinned
            if isPinned{
                isArchived = !isArchived
                pinBtn.setImage(#imageLiteral(resourceName: "fillpin (1)"), for: .normal)
                pinDict["isPined"] = true
                pinDict["noteIdList"] = [noteToEdit?.id] as! [String]
                noteManager.updateNotes(updateDict: pinDict, pathVariable: PathVariables.pinUnpinNotes.rawValue)
                noteManager.getNotes(pathVariable: PathVariables.getNotes.rawValue)

            } else {
                pinBtn.setImage(#imageLiteral(resourceName: "pin"), for: .normal)
                pinDict["isPined"] = false
                pinDict["noteIdList"] = [noteToEdit?.id] as! [String]
                noteManager.updateNotes(updateDict: pinDict, pathVariable: PathVariables.pinUnpinNotes.rawValue)
                noteManager.getNotes(pathVariable: PathVariables.getNotes.rawValue)

            }
        } else {
            isPinned = !isPinned
            if isPinned{
                pinBtn.setImage(#imageLiteral(resourceName: "fillpin (1)"), for: .normal)
            } else {
                pinBtn.setImage(#imageLiteral(resourceName: "pin"), for: .normal)
            }
        }
    }
    
    @IBAction func addRemainder(_ sender: Any) {
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .full
        dateFormat.timeStyle = .full
        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let textFieldDate =  remainderTxtfld.text?.replacingOccurrences(of: "+0530", with: "+0000")
        print(textFieldDate!)
        let date = dateFormat.date(from: textFieldDate!)!
        if isEditable {
            var remainderDict = [String : Any]()
            let remainder = dateFormat.string(from: date)
            remainderDict["reminder"] = remainder
            remainderDict["noteIdList"] = [noteToEdit?.id] as! [String]
            noteManager.updateNotes(updateDict: remainderDict, pathVariable: PathVariables.updateRemainder.rawValue)
            noteManager.getNotes(pathVariable: PathVariables.getNotes.rawValue)

        }
        let dateString = dateFormat.string(from: date)
        let requiredFormat = dateString.toDateString(inputDateFormat: "yyyy-MM-dd HH:mm:ssZ", ouputDateFormat: "MM-dd-yyyy hh:mm", date: date)
        print("Date is \(requiredFormat)")
        registerNotification(date: dateFormat.date(from: requiredFormat)!)
        
    }
    @IBAction func onClickArchive(_ sender: Any) {
        if isEditable {
            var archiveDict = [String : Any]()
            isArchived = !isArchived
            if isArchived {
               isPinned = !isPinned
                archiveDict["isArchived"] = true
                archiveDict["noteIdList"] = [noteToEdit?.id] as! [String]
                noteManager.updateNotes(updateDict: archiveDict, pathVariable: PathVariables.archiveNotes.rawValue)
                noteManager.getNotes(pathVariable: PathVariables.getNotes.rawValue)

            } else {
                archiveDict["isArchived"] = false
                archiveDict["noteIdList"] = [noteToEdit?.id] as! [String]
                noteManager.updateNotes(updateDict: archiveDict, pathVariable: PathVariables.archiveNotes.rawValue)
                noteManager.getNotes(pathVariable: PathVariables.getNotes.rawValue)

            }
           
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addContentClick(_ sender: Any) {
        
    }
    
    @IBAction func addItemsOnClick(_ sender: Any) {
        slideUpMenuSetup()
    }
}

extension String {
    func toDateString( inputDateFormat inputFormat  : String,  ouputDateFormat outputFormat  : String , date : Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        dateFormatter.dateFormat = outputFormat
        return dateFormatter.string(from: date)
    }

}
//extension AddEditNotesVC : UITextViewDelegate {
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textView.textColor == UIColor.lightGray {
//            textView.text = nil
//            textView.textColor = UIColor.black
//        }
//    }
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView.text.isEmpty {
//            textView.text = "Note"
//            textView.textColor = UIColor.lightGray
//        }
//    }
//
//}
