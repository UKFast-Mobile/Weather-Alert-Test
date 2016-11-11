//
//  City+CoreDataProperties.swift
//  Weather Alert
//
//  Created by Aleksandr Kelbas on 11/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City");
    }

    @NSManaged public var deg: NSDecimalNumber?
    @NSManaged public var name: String?
    @NSManaged public var speed: NSDecimalNumber?
    @NSManaged public var lon: NSDecimalNumber?
    @NSManaged public var lat: NSDecimalNumber?
    @NSManaged public var country: String?
    @NSManaged public var id: Int16

}
