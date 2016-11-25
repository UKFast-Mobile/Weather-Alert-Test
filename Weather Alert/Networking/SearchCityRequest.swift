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
    
    init(cityName: String) {
        let path = "/weather?q=\(cityName)"
        super.init(path: path)
    }
    
    func response(completionHandler: @escaping (City) -> Void) {
        handleResponse() { result in
            
            let entity: NSEntityDescription? = NSEntityDescription.entity(forEntityName: "City", in: self.dataController.managedObjectContext)
            let object = City(entity: entity!, insertInto: self.dataController.managedObjectContext)
            
            if let res = result { object.mapping(json: res) }
            completionHandler(object)
        }
    }
    
}
