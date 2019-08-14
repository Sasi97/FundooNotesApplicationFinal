//
//  RegisterVC.swift
//  FundooApp
//
//  Created by BridgeLabz Solutions LLP  on 6/8/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController{
//    let authenticate = FirebaseAuthentication()
    let  dbRepo = SqliteRepositary()
    let  loopbackRepo = UserApiManager()
    @IBOutlet weak var firstNameFld: UITextField!
    @IBOutlet weak var lastNameFld: UITextField!
    @IBOutlet weak var conformPasswordFld: UITextField!
    @IBOutlet weak var passwordFld: UITextField!
    @IBOutlet weak var mobileNumberFld: UITextField!
    @IBOutlet weak var emailFld: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func onClickRegister(_ sender: Any) {
        
        print("onClickRegister clicked!")
        guard let firstName = firstNameFld.text, let lastName = lastNameFld.text , let email = emailFld.text, let mobileNum = mobileNumberFld.text, let password = passwordFld.text else {
            print("error at textfields data")
            return
        }
        let userDetails = User.init( id: 1, firstName: firstName, lastName: lastName, email: email, mobileNum: mobileNum,  password: password)

        loopbackRepo.serverSignUp(user: userDetails)
        sqlliteSaving(user : userDetails)
        //authenticate.firebaseSignUp(email: email, password: password)
        NotificationCenter.default.addObserver(self, selector: #selector(navigateToDash(notification: )), name: NSNotification.Name("SignUpInfo"), object: nil)

    }
    func sqlliteSaving(user : User){
        if dbRepo.insert(with: user) {
            print("User saved in SQLITE")
        }
    }
    @objc func navigateToDash(notification: NSNotification){
        let userData = notification.userInfo!["data"] as! [String : AnyObject]
        let response = notification.userInfo!["response"] as! HTTPURLResponse
        print(userData)
        print(response)
        if response.statusCode == 200 {
            let loginVC  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginVC") as! LoginVC
            DispatchQueue.main.async {
                self.present(loginVC, animated: true, completion: {
                })
            }
            
        } else {
            let alert = AppUtil.getSimpleAlert(messageString: "Incorrect Email & Password")
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
}



//        if firstNameFld.text!.isEmpty || lastNameFld.text!.isEmpty || emailFld.text!.isEmpty || mobileNumberFld.text!.isEmpty || genderFld.text!.isEmpty || dobFld.text!.isEmpty || passwordFld.text!.isEmpty || conformPasswordFld.text!.isEmpty {
//            let alert =  AppUtil.getSimpleAlert(messageString: "*Fields must be filled")
//            present(alert, animated: true, completion: nil)
//
//        }else {
//            if Validation.isEmailValid(email: emailFld.text!) && Validation.isPasswordValid(password: passwordFld.text!) {
//                if dbRepo.isEmailExists(email: emailFld.text!) {
//                    let alert =  AppUtil.getSimpleAlert(messageString: "User Already Exists.Go to login page")
//                    present(alert, animated: true, completion: ({
//                        guard let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as? LoginVC else { return  }
//                        self.present(loginVC, animated: true)
//                    }))
//                }else {
//                    if passwordFld.text == conformPasswordFld.text {
//                        guard let firstName = firstNameFld.text, let lastName = lastNameFld.text , let email = emailFld.text, let mobileNum = mobileNumberFld.text, let gender = genderFld.text, let dob = dobFld.text, let password = passwordFld.text else {return}
//                        let userDetails:User = User(Id: 1, firstName: firstName, lastName: lastName, email: email, mobileNumber: mobileNum, gender: gender, dob: dob, password: password)
//
//
//                    }else {
//                        let passwordAlert =  AppUtil.getSimpleAlert(messageString: "PassWord doesn't matches")
//                        present(passwordAlert, animated: true, completion: nil)
//
//                    }
//                }
//
//            }
//        }
//
//
//
