//
//  SearchCityRequest.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 24/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import Foundation
import CoreData

class SearchCityRequest: NetworkingRequest {
    
    var path: String
    var response: [String : Any]?
    
    init(cityName: String) {
        path = "/weather?q=\(cityName)"
    }
}
