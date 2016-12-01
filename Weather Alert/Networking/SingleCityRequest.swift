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
    
    var city: City?
    
    
    init(cityId: Int) {
        let path = "/weather?id=\(cityId)"
        super.init(path: path)
    }
    
    init(oldCity: City) {
        city = oldCity
        let cityId = oldCity.id!
        let path = "/weather?id=\(cityId)"
        super.init(path: path)
    }
    
    func response(completionHandler: @escaping (City?) -> Void) {
        super.handleResponse() { result in
            if let res = result, let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "City", in: self.dataController.managedObjectContext) {
                
                if let object = self.city {
                    object.mapping(json: res)
                }
                else {
                    self.city = City(entity: entity, insertInto: self.dataController.managedObjectContext, json: res)
                }
                completionHandler(self.city)
            }
            else {
                completionHandler(nil)
            }
        }
    }
}
