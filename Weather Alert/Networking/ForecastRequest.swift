//
//  ForecastRequest.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 18/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import Foundation
import CoreData

class ForecastRequest: NetworkingRequest {
    
    init(cityId: Int) {
        super.init()
        path = "/forecast/daily?id=\(cityId)"
    }
    
    func response(completionHandler: @escaping (Forecast) -> Void) {
        super.handleResponse() { result in
            
            let entity: NSEntityDescription? = NSEntityDescription.entity(forEntityName: "Forecast", in: self.dataController.managedObjectContext)
            let object = Forecast(entity: entity!, insertInto: self.dataController.managedObjectContext)
            
            object.mapping(json: result!)
            completionHandler(object)
        }
    }
    
}
