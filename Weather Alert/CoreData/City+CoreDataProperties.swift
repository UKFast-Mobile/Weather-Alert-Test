//
//  City+CoreDataProperties.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 17/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import CoreData
import UIKit


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City");
    }

    @NSManaged public var country: String?
    @NSManaged public var deg: NSNumber?
    @NSManaged public var id: NSNumber?
    @NSManaged public var lat: NSNumber?
    @NSManaged public var lon: NSNumber?
    @NSManaged public var name: String?
    @NSManaged public var speed: NSNumber?
    
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
