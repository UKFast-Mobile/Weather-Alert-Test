//
//  ForecastRequest.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 18/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import Foundation

class ForecastRequest: NetworkingRequest {
    
    init(cityId: Int) {
        super.init()
        path = "/forecast/daily?id=\(cityId)"
    }
    
    // TODO:: Uncomment after Forecast is added
    
//    func response(completionHandler: @escaping ([String : Any]?) -> Void) {
//        super.handleResponse() { result in
//            
//            let entity: NSEntityDescription? = NSEntityDescription.entity(forEntityName: "Forecast", in: self.dataController.managedObjectContext)
//            let object = Forecast(entity: entity!, insertInto: self.dataController.managedObjectContext)
//            
//            object.mapping(json: result!)
//            
//            let res = object.dataToDictionary()
//            completionHandler(res)
//        }
//    }
    
}
