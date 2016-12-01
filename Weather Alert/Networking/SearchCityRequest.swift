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
    
    func response(completionHandler: @escaping (City?) -> Void) {
        handleResponse() { result in
            if let res = result, let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "City", in: self.dataController.managedObjectContext) {
                
                let object = City(entity: entity, insertInto: self.dataController.managedObjectContext, json: res)
                completionHandler(object)
            }
            else {
                completionHandler(nil)
            }
        }
    }
    
}
