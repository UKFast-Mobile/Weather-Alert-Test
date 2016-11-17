//
//  TestHelper.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 17/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//
import XCTest
import Foundation

extension XCTestCase {
    
    func loadJson(jsonFile: String) -> [String : Any]? {
        
        guard let path = Bundle.main.url(forResource: jsonFile, withExtension: "json"),
            let jsonData = try? Data(contentsOf: path, options: Data.ReadingOptions.mappedIfSafe),
            let jsonResult: [String : Any]? = try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String : Any]
            else { return nil }
        
        return jsonResult
    }
}
