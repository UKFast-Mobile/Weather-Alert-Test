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
        let path = "/forecast/daily?id=\(cityId)"
        super.init(path: path)
    }
    
    func response(completionHandler: @escaping ([Forecast]) -> Void) {
        
        var objects: [Forecast] = []
        handleResponse() { res in
            
            if let result = res, let list = result["list"] as? [[String : Any]] {
                for (idx, _) in list.enumerated() {
                    
                    let entity: NSEntityDescription? = NSEntityDescription.entity(forEntityName: "Forecast", in: self.dataController.managedObjectContext)
                    let object = Forecast(entity: entity!, insertInto: self.dataController.managedObjectContext)
                    
                    object.mapping(json: result, count: idx)
                    objects.append(object)
                }
            }
            completionHandler(objects)
        }
    }
}
