//
//  Networking.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 18/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import Foundation
import CoreData

open class NetworkingRequest {
    
    // MARK: Variables
    
    public var path: String
    public var response: [String : Any]?
    
    var networking: Networking { return AppShared.instances.networking }
    var dataController: DataController { return AppShared.instances.dataController }
    
    init() {
        path = "weather?id=1000006"
    }
    
    // MARK: Functions
    
    func handleResponse(completionHandler: @escaping ([String: Any]?) -> Void) {
        let fullPath = URL(string: "http://api.openweathermap.org/data/2.5\(path)&appid=\(networking.appId)")
        let task = networking.session.dataTask(with: fullPath!, completionHandler: {
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

class Networking {
    
    // MARK: Variables
    
    let config: URLSessionConfiguration
    let session: URLSession
    let appId: String
    
    init(config: URLSessionConfiguration, appId: String) {
        self.config = config
        self.session = URLSession(configuration: self.config)
        self.appId = appId
    }
}
