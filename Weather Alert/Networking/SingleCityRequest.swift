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
    
    let dataController = DataController()
    
    init(cityId: Int) {
        super.init()
        path = "/weather?id=\(cityId)"
    }
    
    func response(completionHandler: @escaping (City) -> Void) {
        super.handleResponse() { result in
            
            let entity: NSEntityDescription? = NSEntityDescription.entity(forEntityName: "City", in: self.dataController.managedObjectContext)
            let object = City(entity: entity!, insertInto: self.dataController.managedObjectContext)
            
            object.mapping(json: result!)
            completionHandler(object)
        }
    }
    
}
