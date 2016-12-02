//
//  CityModel.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 01/12/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import UIKit

class City : DataModel {
    
    var id: NSNumber
    var name: String
    var country: String
    var lat: NSNumber?
    var lon: NSNumber?
    var deg: NSNumber?
    var speed: NSNumber?
    
    init(json: [String : Any]) {
        
        if let id = json["id"] as? NSNumber { self.id = id }
        else { id = 0 }
        if let name = json["name"] as? String { self.name = name }
        else { name = "" }
        if let sys = json["sys"] as? [String : Any], let country = sys["country"] as? String { self.country = country }
        else { country = "" }
        
        mapping(json: json)
    }
    
    internal func mapping(json: [String : Any]) {
        
        if let coord = json["coord"] as? [String : Any], let lat = coord["lat"] as? NSNumber, let lon = coord["lon"] as? NSNumber {
            self.lat = lat
            self.lon = lon
        }
        
        if let wind = json["wind"] as? [String : Any], let deg = wind["deg"] as? NSNumber {
            self.deg = deg
        }
    }
}

extension City {
    
    
    var direction: String {
        
        var direction: String = "Unknown"
        
        if let direct: Int = deg as? Int {
            
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
    
    var windSpeed: String {
        if let s = speed {
            return String(describing: s)+" mph"
        }
        return ""
    }
    
    var windDirectionImage: UIImage? {
        return UIImage(named: "\(direction.lowercased())Image")
    }
    
    var directionLabel: String {
        return "Direction: \(direction)"
    }
    
    var windSpeedLabel: String {
        return "Speed: \(windSpeed)"
    }
}
