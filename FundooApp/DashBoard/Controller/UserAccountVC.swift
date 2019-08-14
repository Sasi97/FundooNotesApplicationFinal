//
//  UserAccountVC.swift
//  FundooApp
//
//  Created by BridgeLabz Solutions LLP  on 7/19/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit
import MaterialComponents

class UserAccountVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    
    
    @IBOutlet weak var signOutBtn: ShadowedButton!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var userView: ShadowedView!
    let imagePicker = UIImagePickerController()
    var imageUrl : URL?
    override func viewDidLoad() {
        super.viewDidLoad()
      
        userView.shadowLayer.elevation = .cardResting
        signOutBtn.setDefaultElevation()
//        bindUserInfo()
        imagePicker.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(profileSettings(notification:)), name: NSNotification.Name("profileSettings"), object: nil)
    
    }
    @objc func profileSettings(notification:NSNotification){
        let imageUrl = notification.userInfo!["profileUrl"] as! String
        let name = notification.userInfo!["profileName"] as! String
        let email = notification.userInfo!["profileEmail"] as! String
        emailLbl.text = email
        nameLbl.text = name
        let url = URL(string: imageUrl)!
        let imageData = try! Data(contentsOf: url)
        let image = UIImage(data: imageData)
        profileImgView.image = image
    }
    func bindUserInfo(){
        let userInfo = UserDefaultsManager.retreiveValue(key: "UserInfo") as! [String : String]
        print(userInfo)
        emailLbl.text = userInfo["email"]
        nameLbl.text =  userInfo["name"]
    }
    @IBAction func viewDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickImageUpload(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
    @IBAction func signOut(_ sender: Any) {
        KeyChainManager.removeValues(service: "UserInfo")
        UserDefaultsManager.setValue(value: false, key: "IsUserLoggedIn")
        UserDefaultsManager.removeValues(key: "UserInfo")
        UserDefaultsManager.removeValues(key: "UserLoginInfo")
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginVC") as! LoginVC
        self.present(loginVC, animated: true){
            print("Signed out")
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImgView.contentMode = .scaleAspectFit
            profileImgView.image = pickedImage
            imageUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL
            print(imageUrl!)

        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func uploadProfilePic() {
        
    }
}
