//
//  ForecastRequest.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 28/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import Foundation
import CoreData

class ForecastRequest: NetworkingRequest {
    
    var path: String
    var response: [String : Any]?
        
    init(cityId: NSNumber) {
        path = "/forecast/daily?id=\(cityId)"
    }
}
