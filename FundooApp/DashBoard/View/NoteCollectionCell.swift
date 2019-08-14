  //
  //  NoteCollectionCell.swift
  //  FundooApp
  //
  //  Created by BridgeLabz Solutions LLP  on 7/24/19.
  //  Copyright © 2019 Apple Inc. All rights reserved.
  //
  
  import UIKit
  
  class NoteCollectionCell: UICollectionViewCell {

    @IBOutlet weak var noteCard: ShadowedView!
    @IBOutlet weak var deleteForeverBtn: ShadowedButton!
    @IBOutlet weak var pinBtn: UIButton!
    @IBOutlet weak var removeRemainder: ShadowedButton!
    @IBOutlet weak var remainderLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
//    @IBOutlet weak var remainderRemoveBtn: ShadowedButton!
//    @IBOutlet weak var noteRemainderLbl: UILabel!
    @IBOutlet weak var remainderCard: ShadowedView!
//    @IBOutlet weak var noteDescLbl: UILabel!
//    @IBOutlet weak var noteTitleLbl: UILabel!
    var cellNote:NoteModel?
    let noteManager = NotesApiManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetUp()
        
    }
    
    func initialSetUp() {
        noteCard.shadowLayer.elevation = .picker
        deleteForeverBtn.setDefaultElevation()
        remainderCard.isHidden = true
        pinBtn.isHidden = true
        pinBtn.setImage(#imageLiteral(resourceName: "pin"), for: .normal)
        deleteForeverBtn.isHidden = true
        removeRemainder.setDefaultElevation()
    }
    func bindNote(note : NoteModel) {
        cellNote = note
        titleLbl.text = note.title
        descLbl.text = note.description
        applyColorToNote(note:note)
        addRemainder(note:note)
        showPinnedNote(note:note)
        showTrashedNote(note:note)
    }
    
    func addRemainder(note:NoteModel) {
        if note.reminder != "" {
            remainderCard.isHidden = false
            remainderCard.shadowLayer.elevation = .cardPickedUp
            remainderCard.shadowLayer.cornerRadius = 10
            remainderLbl.text = note.reminder
        } else {
            remainderCard.isHidden = true
        }
    }
    
    func applyColorToNote(note:NoteModel) {
        if note.color.hasPrefix("#") {
            let startIndex = note.color.index(note.color.startIndex, offsetBy: 1)
            let cellColor = String(note.color[startIndex...])
            noteCard.backgroundColor = UIColor.init(hex: cellColor)
        }

    }
    func showPinnedNote(note:NoteModel) {
        if note.isPined == true {
            pinBtn.isHidden = false
            pinBtn.setImage(#imageLiteral(resourceName: "fillpin (1)"), for: .normal)
        } else {
            pinBtn.isHidden = true
        }
    }
    
    func showTrashedNote(note : NoteModel) {
        if note.isDeleted == true {
            deleteForeverBtn.isHidden = false
        } else {
            deleteForeverBtn.isHidden = true
        }
    }
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
    
    
   
    
    @IBAction func deleteForever(_ sender: UIButton) {
    }
    
    @IBAction func onClickRemoveRemainder(_ sender: UIButton) {
        var removeDict = [String : Any]()
        removeDict["noteIdList"] = [cellNote?.id] as! [String]
        noteManager.updateNotes(updateDict: removeDict, pathVariable: PathVariables.removeReminder.rawValue)
        remainderCard.isHidden = true
        noteManager.getNotes(pathVariable: PathVariables.getNotes.rawValue)
    }
    
    
  }
