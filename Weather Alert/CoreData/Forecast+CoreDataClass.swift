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

public class Forecast: City {
    
    internal func mapping(json: [String : Any], count: Int) {
        
        guard let city = json["city"] as? [String : Any], let list = json["list"] as? [[String : Any]]
            else { return }
        
        guard let coord = city["coord"] as? [String : Any]
            else { return }
        
        let day = list[count]
        
        id = city["id"] as? NSNumber
        name = city["name"] as? String
        country = city["country"] as? String
        date = day["dt"] as? NSNumber
        deg = day["deg"] as? NSNumber
        speed = day["speed"] as? NSNumber
        lon = coord["lon"] as? NSNumber
        lat = coord["lat"] as? NSNumber
    }
}
