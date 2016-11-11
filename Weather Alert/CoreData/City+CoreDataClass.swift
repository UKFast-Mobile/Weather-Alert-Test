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
        
        if let path = Bundle.main.url(forResource: "SingleCity", withExtension: "json") {
            do {
                if let jsonData = try Data(contentsOf: path, options: .dataReadingMapped, Error: nil)? {
                    if let jsonResult: Dictionary = JSONSerialization.data(withJSONObject: jsonData, options: JSONSerialization.WritingOptions) as? Dictionary {
                        if let citys : Array = jsonResult["city"] as? Array {
                            
                        }
                        
                    }
                }
                catch {
                    
                }
                
            }
            
        }
        
        do {
            guard let path = Bundle.main.url(forResource: "SingleCity", withExtension: "json")
                else {
                    // TODO: Throw Error
            }
            guard let jsonData = try Data(contentsOf: path, options: .dataReadingMapped)
                else {
                    // TODO: Throw Error
            }
            
        } catch {
            
        }
        
    }
    
}
