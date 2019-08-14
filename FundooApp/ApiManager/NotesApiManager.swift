//
//  NotesApiManager.swift
//  FundooApp
//
//  Created by BridgeLabz Solutions LLP  on 7/23/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import Foundation
import KeychainAccess

class NotesApiManager {
    func addNotes(note : NoteModel, pathVariable : String) {
        guard  let url:URL = URL(string: baseUrl + pathVariable) else {
            print("url is invalid")
            return
        }
        var urlRequest = HttpConnection.setUrlRequest(url, httpMethod: HttpMethods.Post.rawValue)
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(note)
            print(jsonData as Any)
            urlRequest.httpBody = jsonData
        }catch{
            print("Error")
        }
        HttpConnection.postUrlRequest(urlRequest) { (data, response, error) in
            print(data!)
            print(response!)
        }
        
    }
    func getNotes(pathVariable : String) {
        var noteList = [NoteModel]()
        guard  let url:URL = URL(string: baseUrl + pathVariable) else {
            print("url is invalid")
            return
        }
        let urlRequest = HttpConnection.setUrlRequest(url, httpMethod: HttpMethods.Get.rawValue)
       
        HttpConnection.postUrlRequest(urlRequest) { (data, response, error) in
            
            let noteData = data!["data"]!["data"] as! [[String: AnyObject]]
            for i in 0..<noteData.count {
                let note = NoteModel.init(from: noteData[i])
                    noteList.append(note)
            }
            NotificationCenter.default.post(name: Notification.Name("NotesInfo"), object: nil, userInfo: ["NoteList" : noteList, "response" : response!, "pathVariable" : pathVariable])
            
        }
    }
    
    func updateNotes(updateDict:[String : Any] , pathVariable : String) {
        guard  let url:URL = URL(string: baseUrl + pathVariable) else {
            print("url is invalid")
            return
        }
        var urlRequest = HttpConnection.setUrlRequest(url, httpMethod: HttpMethods.Post.rawValue)
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: updateDict, options: [])
            print(jsonData as Any)
            urlRequest.httpBody = jsonData
        }catch{
            print("Error")
        }
        HttpConnection.postUrlRequest(urlRequest) { (data, response, error) in
            print(data!)
            print(response!)
        }
        
    }
   
    
    
}
   

