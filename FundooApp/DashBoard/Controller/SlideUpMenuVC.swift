//
//  SlideUpMenuVC.swift
//  FundooApp
//
//  Created by BridgeLabz Solutions LLP  on 7/16/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit

class SlideUpMenuVC: UIViewController {
    
   // var images:[UIImage] = [#imageLiteral(resourceName: "trash"),#imageLiteral(resourceName: "collaborator"),#imageLiteral(resourceName: "tag")]
    var labels = ["Delete","Collaborator","Label"]
    var colorData:[UIColor] = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1),#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1),#colorLiteral(red: 0, green: 0.568627451, blue: 0.5764705882, alpha: 0.4945419521),#colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)]
    var color = "FFFFFF"
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    


}
extension SlideUpMenuVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "slideUpMenuCell", for: indexPath) as! SlideUpMenuTableCell
        cell.lbl.text = labels[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            NotificationCenter.default.post(name: NSNotification.Name("DeleteNote"), object: nil)
        }
    }
    
    
}
extension SlideUpMenuVC : UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath) as! ColorCollectionCell
        cell.backgroundColor = colorData[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
             color = ColorsValue.defaultNote.rawValue
        case 1 :
            color = ColorsValue.color1.rawValue
        case 2 :
            color = ColorsValue.color2.rawValue
        case 3 :
            color = ColorsValue.color3.rawValue
        case 4 :
            color = ColorsValue.color4.rawValue
        case 5 :
            color = ColorsValue.color5.rawValue
        case 6 :
            color = ColorsValue.color6.rawValue
        case 7 :
            color = ColorsValue.color7.rawValue
        case 8 :
            color = ColorsValue.color8.rawValue
        default:
            color = ColorsValue.defaultNote.rawValue
        }
        view.backgroundColor = UIColor.init(hex: color)
        tableView.backgroundColor = UIColor.init(hex: color)
        NotificationCenter.default.post(name: NSNotification.Name("colorNotes"), object: nil, userInfo: ["color" : color])
    }
    enum ColorsValue:String{
        case defaultNote = "FFFFFF"
        case color1 = "F4A88B"
        case color2 = "F9D98C"
        case color3 = "B8E297"
        case color4 = "79D6F9"
        case color5 = "8E5AF7"
        case color6 = "999999"
        case color7 = "009193"
        case color8 = "B97A19"
    }
    
}
