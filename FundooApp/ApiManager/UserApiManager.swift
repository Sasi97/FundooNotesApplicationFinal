//
//  UserApiManager.swift
//  FundooApp
//
//  Created by BridgeLabz Solutions LLP  on 7/12/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import Foundation

class UserApiManager {
    var session = URLSession.shared
    func serverSignUp(user : User)  {
        guard  let url:URL = URL(string: baseUrl + "user/userSignUp") else {
            print("url is invalid")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json; charset = utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.httpMethod = HttpMethods.Post.rawValue
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(user.asDict())
            print(jsonData as Any)
            urlRequest.httpBody = jsonData
        }catch{
            print("Error")
        }
        HttpConnection.postUrlRequest(urlRequest) { (data, response, error) in
            NotificationCenter.default.post(name: Notification.Name("SignUpInfo"), object: nil, userInfo: ["data" : data!, "response" : response!])
        }
        
    }
    func serverLogin(credentials: Dictionary<String, String>) {
        guard let url = URL(string: baseUrl+"user/login") else { return }
        var urlRequest:URLRequest = URLRequest.init(url: url)
        urlRequest.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = HttpMethods.Post.rawValue
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(credentials)
            urlRequest.httpBody = jsonData
        }catch {
            print("Error")
        }
//        HttpConnection.request(urlRequest) { (data, response, error) in
//             NotificationCenter.default.post(name: NSNotification.Name("LoginInfo"), object: nil, userInfo: ["data":data,"response":response])
//        }
        loginRequest(urlRequest)
       
    }
    func loginRequest(_ request : URLRequest) {
        
        session.dataTask(with: request) {(data, urlResponse, error)  in
            guard let data = data else {
                print("error with data")
                return
            }
            print(data)
            let jsonData = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : AnyObject]
            guard let response = urlResponse as? HTTPURLResponse else {
                print("error with response")
                return
            }
            NotificationCenter.default.post(name: NSNotification.Name("LoginInfo"), object: nil, userInfo: ["data":jsonData,"response":response])
            
            if error != nil{
                print("error")
            }
            }.resume()
    }
   
//    func uploadProfilePicToServer(imageData : Data) {
//        if imageData != nil{
//            guard let url = URL(string: baseUrl+PathVariables.uploadProfilePic.rawValue) else { return }
//
//            var request = URLRequest.init(url: url)
//            print(request)
//            
//            request.httpMethod = HttpMethods.Post.rawValue
//            
//            let boundary = NSString(format: "---------------------------14737809831466499882746641449")
//            let contentType = NSString(format: "multipart/form-data; boundary=%@",boundary)
//            //  println("Content Type \(contentType)")
//            request.addValue(contentType as String, forHTTPHeaderField: "Content-Type")
//            
//            var body = Data()
//            
//            body.append(NSString(format: "\r\n--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
//            body.append(NSString(format:"Content-Disposition: form-data;name=\"title\"\r\n\r\n").data,
//                count: (using:String.Encoding.utf8.rawValue)!)
//            body.append("Hello".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
//            
//            
//            body.append(NSString(format: "\r\n--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
//            body.append(NSString(format:"Content-Disposition: form-data;name=\"uploaded_file\";filename=\"image.jpg\"\\r\n").data,
//                count: (using:String.Encoding.utf8.rawValue)!) //Here replace your image name and file name
//            body.append(NSString(format: "Content-Type: image/jpeg\r\n\r\n").data(using: String.Encoding.utf8.rawValue)!)
//            body.append(imageData)
//            body.append(NSString(format: "\r\n--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
//            
//            request.httpBody = body
//    }
//    }
}
