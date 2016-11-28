//
//  NetworkingRequest.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 24/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import Foundation
import CoreData

open class NetworkingRequest {
    
    // MARK: Variables
    
    let path: String
    var response: [String : Any]?
    
    var networking: Networking { return AppShared.instances.networking }
    var dataController: DataController { return AppShared.instances.dataController }
        
    init(path : String) {
        self.path = path.sanitizeStringURL();
    }
    
    // MARK: Functions
    
    func handleResponse(completionHandler: @escaping ([String: Any]?) -> Void) {
        let fullPath = URL(string: "http://api.openweathermap.org/data/2.5\(path)&appid=\(networking.appId)")
        let task = networking.session.dataTask(with: fullPath!, completionHandler: {
            (data, response, error) in
                
            if error != nil {
                completionHandler(nil)
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {
                    completionHandler(json)
                }
            } catch {
                completionHandler(nil)
            }
        })
        task.resume()
    }
    
}

extension String {
    func sanitizeStringURL() -> String {
        return self.replacingOccurrences(of: " ", with: "%20")
    }
}

//%20
