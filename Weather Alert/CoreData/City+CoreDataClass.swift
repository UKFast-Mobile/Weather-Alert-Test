//
//  CoreCity+CoreDataClass.swift
//  Weather Alert
//
//  Created by Aleksandr Kelbas on 11/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import Foundation
import CoreData

protocol DataModel {
    func mapping(json: [String : Any])
}

class CoreCity: NSManagedObject, DataModel {


    convenience init(entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "CoreCity", in: AppShared.instances.dataController.managedObjectContext)!, insertInto: NSManagedObjectContext? = AppShared.instances.dataController.managedObjectContext, json: [String : Any]) {
        
        self.init(entity: entity, insertInto: insertInto)
        
        guard let _ = json["id"] as? NSNumber,
            let _ = json["name"] as? String
            else { return }

        mapping(json: json)
    }
    
    internal func mapping(json: [String : Any]) {
        
        if let _ = favourite {}
        else { favourite = false }
        
        id = json["id"] as? NSNumber
        name = json["name"] as? String
        
        if let sys = json["sys"] as? [String : Any] {
            country = sys["country"] as? String
            
        }
        
        if let coord = json["coord"] as? [String : Any] {
            lon = coord["lon"] as? NSNumber
            lat = coord["lat"] as? NSNumber
        }
        
        if let wind = json["wind"] as? [String : Any] {
            deg = wind["deg"] as? NSNumber
            speed = wind["speed"] as? NSNumber
        }
    }
}
