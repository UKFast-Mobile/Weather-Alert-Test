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
    
    init(config: URLSessionConfiguration = URLSessionConfiguration.default, appId: String) {
        self.config = config
        self.session = URLSession(configuration: self.config)
        self.appId = appId
    }
}
