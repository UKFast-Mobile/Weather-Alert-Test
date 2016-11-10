//
//  City+CoreDataProperties.swift
//  Weather Alert
//
//  Created by Aleksandr Kelbas on 10/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City");
    }


}
