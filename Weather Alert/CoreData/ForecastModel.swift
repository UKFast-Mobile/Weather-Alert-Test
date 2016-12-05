//
//  FullForecastModel.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 28/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import UIKit

class Forecast: DataModel {
    
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

extension Forecast {
    
    func speedLabel(index: Int) -> String {
        let data = self.forecast[index]
        if let speed = data["speed"] {
            return "Speed: \(speed) mph"
        }
        return ""
    }
    
    func dateLabel(index: Int) -> String {
        let data = self.forecast[index]
        if let dt = data["dt"] as? Double {
            return AppShared.instances.timeStampFormatter.dateFormatter(date: dt)
        }
        return ""
    }
    
    func direction(index: Int) -> String {
        
        var direction: String = "Unknown"
        let data = self.forecast[index]
        
        if let direct = data["deg"] as? Int {
            
            if direct > 315 || direct <= 45 {
                direction = "North"
            } else if direct > 45 && direct <= 135 {
                direction = "East"
            } else if direct > 135 && direct <= 225 {
                direction = "South"
            } else if direct > 225 && direct <= 315 {
                direction = "West"
            }
        }
        return direction
    }
    
    
    func directionLabel(index: Int) -> String {
        return "Direction: \(direction(index: index))"
    }
    
    
    func directionImage(index: Int) -> UIImage? {
        return UIImage(named: "\(direction(index: index).lowercased())Image")
    }
}
