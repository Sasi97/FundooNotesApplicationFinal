//
//  SideMenuVC.swift
//  FundooApp
//
//  Created by BridgeLabz Solutions LLP  on 7/13/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit

class SideMenuVC: UIViewController {

    var arraylabels = ["Notes","Remainders","Archived","Trash"]
    var noteManager = NotesApiManager()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
extension SideMenuVC : UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraylabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell") as! SideMenuTableCell
        cell.cellLabel.text = arraylabels[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var index:Int
        switch indexPath.row {
        case 0 :
//            noteManager.getNotes(pathVariable: PathVariables.getNotes.rawValue)
            index = 0
            SJSwiftSideMenuController.hideLeftMenu()
        case 1 :
//            noteManager.getNotes(pathVariable: PathVariables.getRemainderNotes.rawValue)
            index = 1
            SJSwiftSideMenuController.hideLeftMenu()

        case 2 :
//            noteManager.getNotes(pathVariable: PathVariables.getArchiveNotes.rawValue)
            index = 2
            SJSwiftSideMenuController.hideLeftMenu()
        case 3 :
//            noteManager.getNotes(pathVariable: PathVariables.getTrashNotes.rawValue)
            index = 3
            SJSwiftSideMenuController.hideLeftMenu()
        default:
//            noteManager.getNotes(pathVariable: PathVariables.getNotes.rawValue)
            index = 0
        }
        NotificationCenter.default.post(name: Notification.Name("TypeOfNotes"), object: nil, userInfo: ["index" : index])
    }
    
}
