//
//  FullForecastModel.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 28/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import Foundation

public class Forecast: DataModel {
    
    let name: String
    let id: NSNumber
    var forecast: [[String : Any]] = []
    
    init(json: [String : Any]) {
        
        if let city = json["city"] as? [String : Any], let cityId = city["id"] as? NSNumber, let cityName = city["name"] as? String {
            id = cityId
            name = cityName
            mapping(json: json)
        }
        else {
            name = ""
            id = 0
        }
    }
    
    func mapping(json: [String : Any]) {
        
        if let list = json["list"] as? [[String : Any]] {
            for (_, city) in list.enumerated() {
                var day: [String : Any] = [:]
                day["speed"] = city["speed"]
                day["deg"] = city["deg"]
                day["dt"] = city["dt"]
                forecast.append(day)
            }
        }
        
    }
}
