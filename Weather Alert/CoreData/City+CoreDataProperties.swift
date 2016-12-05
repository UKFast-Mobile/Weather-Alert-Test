//
//  CoreCity+CoreDataProperties.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 17/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import CoreData
import UIKit


extension CoreCity: CityProtocol {

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
