//
//  DashBoardVC.swift
//  FundooApp
//
//  Created by BridgeLabz Solutions LLP  on 7/12/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit
import MaterialComponents
import MaterialComponents.MaterialShadowElevations
import MaterialComponents.MaterialIcons
import Reachability
class DashboardVC: UIViewController {
    @IBOutlet weak var layoutChangeBtn: UIButton!
    @IBOutlet weak var userBtn: ShadowedButton!
    @IBOutlet weak var sideMenuBtn: ShadowedButton!
    @IBOutlet weak var navigationView: ShadowedView!
    @IBOutlet weak var noteButton:ShadowedButton!
    @IBOutlet weak var searchBar: UISearchBar!
    var isSideMenu = false
    var isSearching = false
    var isDisplayTypeList = false
    var inListView = true
    var isDataLoaded = false
    var fetchOffSet = 0
    var totalCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationView.shadowLayer.elevation = .cardResting
        noteButton.shadowLayer.elevation = .cardResting
        searchBar.delegate = self
        searchBar.isHidden = true
        
    }
//    
//
//     
    @IBAction func onClickSearchNote(_ sender: UIButton) {
        searchBar.isHidden = false
        
    }
    
    @IBAction func sideMenuClicked(_ sender: UIButton) {
        SJSwiftSideMenuController.showLeftMenu()
    }
    
    @IBAction func takeOnNote(_ sender: UIButton) {
        guard let notesVC = self.storyboard?.instantiateViewController(withIdentifier: "notesVC") as? AddEditNotesVC else { return  }
        self.present(notesVC, animated: true) {
            notesVC.isEditable = false
        }
        
    }
    
    
    @IBAction func collectionLayoutChange(_ sender: UIButton) {
        isDisplayTypeList = !isDisplayTypeList
        if isDisplayTypeList {
            layoutChangeBtn.setImage(#imageLiteral(resourceName: "baseline_list"), for: .normal)
        } else {
            layoutChangeBtn.setImage(#imageLiteral(resourceName: "baseline_dashboard_black"), for: .normal)

        }
        NotificationCenter.default.post(name: Notification.Name("ChangeLayout"), object: nil)


    }
  
    
    @IBAction func onClickUser(_ sender: Any) {
        guard let userVC = self.storyboard?.instantiateViewController(withIdentifier: "userVC") as? UserAccountVC else { return }
        self.present(userVC, animated: true) {
            userVC.bindUserInfo()
        }
    }
  
   
}















//    @objc func getUserNotes(notification : Notification) {
//        let list = notification.userInfo!["NoteList"] as! [NoteModel]
//        let response = notification.userInfo!["response"] as! HTTPURLResponse
//        if response.statusCode == 200 {
//            DispatchQueue.main.async {
//                self.noteHelper.deleteAllNotes()
//                for note in list {
//                    self.noteHelper.saveNote(note: note)
//                }
//            }
//
//        }
//        pathVariable = notification.userInfo!["pathVariable"] as! String
//        noteList = list.filter({ (note) -> Bool in
//            return !note.isDeleted && !note.isArchived
//        })
//        pinnedNotes = list.filter({ (note) -> Bool in
//            return note.isPined
//        })
//        listOfNotes = list.filter({ (note) -> Bool in
//            return !note.isDeleted && !note.isArchived && !note.isPined
//        })
//        archivedNotes = list.filter({ (note) -> Bool in
//            return note.isArchived
//        })
//        remainderNotes = list.filter({ (note) -> Bool in
//            return !note.reminder.isEmpty && !note.isDeleted
//        })
//        trashNotes = list.filter({ (note) -> Bool in
//            return note.isDeleted
//        })
//        showNotes(pathVariable:pathVariable)
//        DispatchQueue.main.async {
//
//            self.notesCollectionView.reloadData()
//        }
//    }



//    func initNotes()  {
//        NotificationCenter.default.addObserver(self, selector: #selector(getUserNotes(notification:)), name: Notification.Name("NotesInfo"), object: nil)
//    }
