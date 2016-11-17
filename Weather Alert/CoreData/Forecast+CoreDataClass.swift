//
//  Forecast+CoreDataClass.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 17/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import Foundation
import CoreData


public class Forecast: City {
    
    func mapping(json: [String : Any], count: Int) {
        
        if let city = json["city"] as? [String : Any] {
            
            id = city["id"] as? NSNumber
            name = city["name"] as? String
            country = city["country"] as? String
            
            if let coord = city["coord"] as? [String : Any] {
                lon = coord["lon"] as? NSNumber
                lat = coord["lat"] as? NSNumber
            }
        }
        
        if let list = json["list"] as? [[String : Any]] {
            
            let ob = list[count] as [String : Any]
            
            date = ob["dt"] as? NSNumber
            deg = ob["deg"] as? NSNumber
            speed = ob["speed"] as? NSNumber
            
        }
    }
}
