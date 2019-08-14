//
//  HttpConnection.swift
//  FundooApp
//
//  Created by BridgeLabz Solutions LLP  on 7/17/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

import Foundation
typealias Dict = [String : [String : AnyObject]]
class HttpConnection {
    static var session = URLSession.shared
    static func setUrlRequest(_ url: URL, httpMethod : String) -> URLRequest {
        let accessToken = KeyChainManager.getValue(service: "UserInfo", key: "AccessToken")
        print(" connection time accesToken \(accessToken)")
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json; charset = utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue(accessToken, forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = httpMethod
        return urlRequest
    }
    static func postUrlRequest(_ request : URLRequest, completion : @escaping (Dict?, HTTPURLResponse?, Error?) -> Void) {
        
        session.dataTask(with: request) {(data, urlResponse, error)  in
            guard let data = data else {
                print("error with data")
                return
            }
            print(data)
            let jsonData = try! JSONSerialization.jsonObject(with: data, options: []) as! Dict
            guard let response = urlResponse as? HTTPURLResponse else {
                print("error with response")
                return
            }
            completion(jsonData, response, nil)
            if error != nil{
                print("error")
                completion(nil, nil, error)
            }
        }.resume()
    }
}
