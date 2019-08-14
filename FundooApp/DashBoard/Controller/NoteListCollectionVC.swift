//
//  NoteListCollectionVC.swift
//  FundooApp
//
//  Created by BridgeLabz Solutions LLP  on 8/13/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit

private let reuseIdentifier = "noteCell"

enum DisplayType {
    case list, grid
}

class NoteListCollectionVC: UICollectionViewController {

    
    var listOfNotes = [NoteModel]()
    var noteManager = NotesApiManager()
    let noteHelper = CoreDataNoteHelper()
    var pathVariable = PathVariables.getNotes.rawValue
    var isDataLoaded = false
    var fetchOffSet = 0
    var isSearching = false
    var totalCount = 0
    var filterNotes = [NoteModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register cell classes
        self.collectionView!.register(UINib.init(nibName: "NoteCollectionCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        addObserver()
        searchObservers()
        collectionView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchData()
        configureCell(displayType: displayType)
        addObserver()
        searchObservers()
        collectionView.reloadData()
        
    }
    private func configureCell(displayType : DisplayType) {
                var estimatedWidth : CGFloat {
                    let deviceEstimatedWidth = collectionView.frame.width - 15
                    switch displayType {
                    case .list : return deviceEstimatedWidth
                    case .grid : return (deviceEstimatedWidth / 2)
                    }
                }
        
                if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                    flowLayout.estimatedItemSize = CGSize(width: estimatedWidth, height: 101)
                }
            }
    
    
        private var displayType : DisplayType = .list {
            didSet {
                configureCell(displayType: displayType)
            }
        }
    
  
    func checkForInternet() -> Bool{
        var isConnectionEstablished = false
        NetworkManager.isReachable { _ in
            isConnectionEstablished = true
        }
        NetworkManager.isUnreachable { _ in
            isConnectionEstablished = false
        }
        return isConnectionEstablished
    }
    
    func fetchData() {
        if checkForInternet() {
            fetchServerData()
        } else {
            print("NO Internet")
        }
        
    }
    
    func fetchServerData() {
        noteManager.getNotes(pathVariable: pathVariable)
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(getUserNotes(notification:)), name: Notification.Name("NotesInfo"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeDisplayType), name: Notification.Name("ChangeLayout"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(displayNotes(notification:)), name: Notification.Name("TypeOfNotes"), object: nil)
    }
    
    func searchObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(didSearchTextChange(notification:)), name: Notification.Name("SearchingNote"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(cancelSearching), name: Notification.Name("EndSearching"), object:nil)
         NotificationCenter.default.addObserver(self, selector: #selector(didSearchBarStartEditing), name: Notification.Name("SearchBarActive"), object:nil)
         NotificationCenter.default.addObserver(self, selector: #selector(didSearchBarEndEditing), name: Notification.Name("SearchBarEndEditing"), object:nil)
        
    }
    
    @objc func displayNotes(notification : Notification) {
        let index = notification.userInfo!["index"] as! Int
        switch index {
        case 0:
            listOfNotes = listOfNotes.filter({ (note) -> Bool in
                return !note.isArchived && !note.isDeleted
            })
            collectionView.reloadData()
        case 1:
            listOfNotes = listOfNotes.filter({ (note) -> Bool in
                return !note.reminder.isEmpty && !note.isDeleted
            })
            collectionView.reloadData()
        case 2:
            listOfNotes = listOfNotes.filter({ (note) -> Bool in
                return note.isArchived && !note.isDeleted
            })
            collectionView.reloadData()
        case 3:
            listOfNotes = listOfNotes.filter({ (note) -> Bool in
                return note.isDeleted
            })
            collectionView.reloadData()
        default:
           print("hello")
        }
    }
    @objc func didSearchBarStartEditing() {
        isSearching = true
        collectionView.reloadData()
    }
    @objc func didSearchBarEndEditing() {
        isSearching = false
//        collectionView.reloadData()
    }
    @objc func didSearchTextChange(notification:Notification) {
        isSearching = true
         let searchedText = notification.userInfo!["searchText"] as! String
        filterNotes.removeAll()
        filterNotes = listOfNotes.filter({
            (($0.title.lowercased().range(of: searchedText.lowercased())) != nil) || (($0.description.lowercased().range(of: searchedText.lowercased())) != nil)
        })
        isSearching = (filterNotes.count == 0) ? false: true
        collectionView.reloadData()
    }
    
    @objc func cancelSearching() {
        isSearching = false
        collectionView.reloadData()
    }
    @objc func getUserNotes(notification : Notification) {
        let list = notification.userInfo!["NoteList"] as! [NoteModel]
        DispatchQueue.main.async {
            self.noteHelper.deleteAllNotes()
            for note in list {
                self.noteHelper.saveNote(note: note)
            }
//            self.listOfNotes.removeAll()
            self.listOfNotes = self.noteHelper.fetchLocalNotes(fetchOffSet: self.fetchOffSet)
            print("Local notes count \(self.listOfNotes.count)")
            self.collectionView.reloadData()
        }
        totalCount = list.count
    }
    
    
    @objc func changeDisplayType() {
        switch displayType {
        case .list:
            displayType = .grid
            
        case .grid:
            displayType = .list
        }
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
    }
   

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching {
            return filterNotes.count
        } else {
            return listOfNotes.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NoteCollectionCell
        if isSearching{
            cell.bindNote(note: filterNotes[indexPath.row])
//            cellAnimation(cell: cell)
        }
        else{
            cell.bindNote(note: listOfNotes[indexPath.row])
//            cellAnimation(cell: cell)
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let noteVC = self.storyboard?.instantiateViewController(withIdentifier: "notesVC") as? AddEditNotesVC else {
            print("failed to navigate")
            return
        }
       if isSearching{
            let note = filterNotes[indexPath.row]
            passingData(note: note, controllerConstant: noteVC)
            // noteVC.modalTransitionStyle = .crossDissolve
            present(noteVC, animated: true, completion: nil)
        }
        else {
            let note = listOfNotes[indexPath.row]
            passingData(note: note, controllerConstant: noteVC)
            // noteVC.modalTransitionStyle = .crossDissolve
            present(noteVC, animated: true, completion: nil)
        }
        
    }
    
    func passingData(note : NoteModel, controllerConstant : AddEditNotesVC){
        controllerConstant.noteToEdit = note
        controllerConstant.isEditable = true
        if note.color.hasPrefix("#") {
            let startIndex = note.color.index(note.color.startIndex, offsetBy: 1)
            let cellColor = String(note.color[startIndex...])
            controllerConstant.setColor(color: cellColor)
        }
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset: CGFloat = scrollView.contentOffset.y
        let maximumOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height
        if maximumOffset - currentOffset <= 50.0 {
            if listOfNotes.count < totalCount {
                fetchOffSet = fetchOffSet + 5
                let list = noteHelper.fetchLocalNotes(fetchOffSet: fetchOffSet)
                for i in 0..<list.count {
                    listOfNotes.append(list[i])
                }
                print("after paging listofnotes count:\(listOfNotes.count)")
                collectionView.reloadData()
            }
        }
    }
    func cellAnimation(cell:NoteCollectionCell) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(withDuration: 0.3, animations: {
            cell.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
        },completion: { finished in
            UIView.animate(withDuration: 0.1, animations: {
                cell.layer.transform = CATransform3DMakeScale(1,1,1)
            })
        })
        
    }
}
