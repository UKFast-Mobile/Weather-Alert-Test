//
//  CoreCity+CoreDataProperties.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 17/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import CoreData
import UIKit


extension CoreCity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreCity> {
        return NSFetchRequest<CoreCity>(entityName: "CoreCity");
    }
    
    @NSManaged public var name: String?
    @NSManaged public var country: String?
    @NSManaged public var id: NSNumber?
    @NSManaged public var lat: NSNumber?
    @NSManaged public var lon: NSNumber?
    @NSManaged public var deg: NSNumber?
    @NSManaged public var speed: NSNumber?
    @NSManaged public var favourite: NSNumber?
    
}

extension CoreCity {
    
    
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
