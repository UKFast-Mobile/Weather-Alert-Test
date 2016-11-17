//
//  Forecast+CoreDataClass.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 15/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

@objc(Forecast)
public class Forecast: NSManagedObject {
    func mapping(json: [String : Any]) {
        
        if let city = json[]
        id = json ["id"] as? NSNumber
        name = json["name"] as? String
        
        if let sys = json["sys"] as? [String : Any] {
            country = sys["country"] as? String
            
        }
        
        if let coord = json["coord"] as? [String : Any] {
            lon = coord["lon"] as? NSNumber
            lat = coord["lat"] as? NSNumber
        }
    }
}
