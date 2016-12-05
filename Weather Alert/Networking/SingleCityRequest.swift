//
//  SingleCityRequest.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 21/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import Foundation
import CoreData

class SingleCityRequest: NetworkingRequest {
    
    var path: String
    var response: [String : Any]?
    
    init(cityId: NSNumber) {
        path = "/weather?id=\(cityId)"
    }
}
