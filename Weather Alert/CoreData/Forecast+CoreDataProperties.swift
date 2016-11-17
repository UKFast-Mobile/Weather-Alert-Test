//
//  Forecast+CoreDataProperties.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 15/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Forecast {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Forecast> {
        return NSFetchRequest<Forecast>(entityName: "Forecast");
    }

    @NSManaged public var id: NSNumber?
    @NSManaged public var name: String?
    @NSManaged public var country: String?
    @NSManaged public var deg: NSNumber?
    @NSManaged public var lat: NSNumber?
    @NSManaged public var lon: NSNumber?
    @NSManaged public var speed: NSNumber?

}
