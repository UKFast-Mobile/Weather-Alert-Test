//
//  DataModelProtocols.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 05/12/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import UIKit

protocol DataModel {
    func mapping(json: [String : Any])
}

protocol CityProtocol : DataModel {
    
    var id: NSNumber? { get set }
    var name: String? { get set }
    var country: String? { get set }
    var lat: NSNumber? { get set }
    var lon: NSNumber? { get set }
    var deg: NSNumber? { get set }
    var speed: NSNumber? { get set }
}

extension CityProtocol {
    
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
