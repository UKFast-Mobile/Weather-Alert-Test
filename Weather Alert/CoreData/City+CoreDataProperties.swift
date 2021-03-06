//
//  City+CoreDataProperties.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 17/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import Foundation
import CoreData


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
