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
    
    let config: URLSessionConfiguration
    let session: URLSession
    let appId: String
    let baseURL: String = "http://api.openweathermap.org/data/2.5"

    init(config: URLSessionConfiguration = URLSessionConfiguration.default, appId: String) {
        self.config = config
        self.session = URLSession(configuration: self.config)
        self.appId = appId
    }
    
    func sendRequest(_ request: NetworkingRequest, whenDone completion:@escaping (([String : Any]?, Error?) -> ())) {
        
        let path = URL(string: "\(baseURL)\(request.path)&appid=\(appId)".sanitizeStringURL())!
        
        let task = session.dataTask(with: path, completionHandler: {
            (data, response, error) in
            DispatchQueue.main.async {
                if error != nil {
                    return completion(nil, error)
                }

                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {
                        completion(json, nil)
                    }
                } catch let err  {
                    completion(nil, err)
                }
            }
        })
        task.resume()
    }
}

private extension String {
    func sanitizeStringURL() -> String {
        return self.replacingOccurrences(of: " ", with: "%20")
    }
}
