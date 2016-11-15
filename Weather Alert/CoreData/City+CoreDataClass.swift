//
//  City+CoreDataClass.swift
//  Weather Alert
//
//  Created by Aleksandr Kelbas on 11/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import Foundation
import CoreData


public class City: NSManagedObject {
    
    func mapping() {
//        let dict: [String : Any] = [:]
    
//        Bundle.main.path(forResource: "city", ofType: "json")
        
//        Bundle.main.url(forResource: "city", withExtension: "json")
        
//        Data(contentsOf: <#T##URL#>, options: <#T##Data.ReadingOptions#>)
        
        do {
            let path = Bundle.main.url(forResource: "SingleCity", withExtension: "json")
            let jsonData = try? Data(contentsOf: path!, options: Data.ReadingOptions.mappedIfSafe)
            
            if let jsonResult: [String : Any] = try JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String : Any] {
                id = jsonResult["id"] as! Int16
                name = jsonResult["name"] as? String
                country = jsonResult["country"] as? String
                deg = jsonResult["deg"] as? NSDecimalNumber
                lon = jsonResult["lon"] as? NSDecimalNumber
                lat = jsonResult["lat"] as? NSDecimalNumber
                speed = jsonResult["speed"] as? NSDecimalNumber
            }
            
        } catch {
            print("Stopped at City")
        }
    }
}
