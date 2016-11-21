//
//  Networking.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 18/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import Foundation
import CoreData

class Networking {
    
    // MARK: Variables
    
    static let inst = Networking()
    
    let config: URLSessionConfiguration
    let session: URLSession
    let appId: String
    
    init() {
        self.config = URLSessionConfiguration.default
        self.session = URLSession(configuration: self.config)
        self.appId = "95fcc97498d7e406f5467cf3dc17f577"
    }
}

open class NetworkingRequest {
    
    // MARK: Variables
    
    public var path: String
    public var response: [String : Any]?
    
    init() {
        path = ""
    }
    
    // MARK: Functions
    
    func handleResponse(completionHandler: @escaping ([String: Any]?) -> Void) {
        let fullPath = URL(string: "http://api.openweathermap.org/data/2.5\(path)" + "&appid=\(Networking.inst.appId)")!
        let task = Networking.inst.session.dataTask(with: fullPath, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                completionHandler(nil)
            } else {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {
                        completionHandler(json)
                    }
                } catch {
                    print("error in JSONSerialization")
                }
            }
        })
        task.resume()
    }
}
