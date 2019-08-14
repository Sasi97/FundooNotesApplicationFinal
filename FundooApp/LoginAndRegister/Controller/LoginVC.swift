//
//  LoginVC.swift
//  FundooApp
//
//  Created by BridgeLabz Solutions LLP  on 6/8/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit
import GoogleSignIn
import KeychainAccess


class LoginVC: UIViewController,GIDSignInDelegate,GIDSignInUIDelegate {
    
    
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    let loopbackRepo = UserApiManager()
//    let authenticate = kSecUseAuthenticationUI()
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaultsManager.isUserLogged(key: "IsUserLoggedIn")  {
            verifyUser()
        }
       
        
    }
    private func verifyUser() {
        loopbackRepo.serverLogin(credentials: UserDefaultsManager.retreiveValue(key: "UserLoginInfo") as! [String : String])
        NotificationCenter.default.addObserver(self, selector: #selector(navigateToDash(notification: )), name: NSNotification.Name("LoginInfo"), object: nil)
    }
  
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print("\(error.localizedDescription)")
        }
        print("\(String(describing: user?.profile?.email))")
        print(user.profile.imageURL(withDimension: 40)!)
         NotificationCenter.default.post(name: NSNotification.Name("GoogleUser"), object: nil, userInfo: ["User":user!])
    }
    
    @IBAction func onClickSignIn(_ sender: Any) {
        if !emailTxtFld.text!.isEmpty && !passwordTxtFld.text!.isEmpty {
            UserDefaultsManager.setUser(value: true, key: "IsUserLoggedIn") 
            let loginDict = ["email" : emailTxtFld.text, "password" : passwordTxtFld.text]
            UserDefaultsManager.setValue(value: loginDict, key: "UserLoginInfo")
           // authenticate.firebaseSignIn(email: emailTxtFld.text!, password: passwordTxtFld.text!)
            loopbackRepo.serverLogin(credentials: loginDict as! Dictionary<String, String>)
            NotificationCenter.default.addObserver(self, selector: #selector(navigateToDash(notification: )), name: NSNotification.Name("LoginInfo"), object: nil)
        }
        
        
    }
    
    @IBAction func onClickSignUp(_ sender: Any) {
        guard let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "registerVC") as? RegisterVC else { return  }
        self.present(registerVC, animated: true)
    }
    
    @IBAction func onClickGoogleSignIn(_ sender: Any) {
        
        GIDSignIn.sharedInstance().delegate=self
        GIDSignIn.sharedInstance().uiDelegate=self
        GIDSignIn.sharedInstance().signIn()
         NotificationCenter.default.addObserver(self, selector: #selector(gSignInNavigation(notification:)), name: NSNotification.Name("GoogleUser"), object: nil)
        
    }
    @objc func gSignInNavigation(notification : NSNotification){
        let user = notification.userInfo!["User"] as! GIDGoogleUser
        if user != nil{
            print("user exist \(user)")
            guard let dashBoardVC = UIStoryboard(name: "DashBoard", bundle: nil).instantiateViewController(withIdentifier: "dashBoardVC") as? DashboardVC else {return }
            self.present(dashBoardVC, animated: true){
                NotificationCenter.default.post(name: NSNotification.Name("profileSettings"), object: nil, userInfo: ["profileUrl":user.profile.imageURL(withDimension: 20)!,"profileName":user.profile.name!,"profileEmail":user.profile.email!])
            }
        }
    }
    @objc func navigateToDash(notification: NSNotification){
        let userData = notification.userInfo!["data"] as! [String : AnyObject]
        let response = notification.userInfo!["response"] as! HTTPURLResponse
        print(userData)
        print(response)
        if response.statusCode == 200 {
//            let dashVC = DashboardVC(coder: nil)
            let dashVC  = UIStoryboard(name: "DashBoard", bundle: nil).instantiateViewController(withIdentifier: "dashBoardVC") as! DashboardVC
            KeyChainManager.setValue(service: "UserInfo", key: "AccessToken", value: userData["id"] as! String )
            let accessToken = KeyChainManager.getValue(service: "UserInfo", key: "AccessToken")
            print("login time acesstoken \(accessToken)")
            let userDict = ["name" : userData["firstName"] as! String, "email": userData["email"] as! String]
            UserDefaultsManager.setValue(value: userDict , key: "UserInfo") 
            DispatchQueue.main.async {
                
                self.navigationController?.pushViewController(viewController: SideMenuHelper.getSideMenu(dashVC, identifier: "dashBoardVC" ), animated: true, completion: {
                })
            }
        } else {
            let alert = AppUtil.getSimpleAlert(messageString: "Incorrect Email & Password")
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
}
