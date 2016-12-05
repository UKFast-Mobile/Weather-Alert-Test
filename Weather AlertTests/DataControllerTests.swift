//
//  DataControllerTests.swift
//  Weather Alert
//
//  Created by Aleksandr Kelbas on 10/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import XCTest
import CoreData
import Foundation
@testable import Weather_Alert

class DataControllerTests: XCTestCase {
    
      var dataController: DataController { return AppShared.instances.dataController }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testDataControllerSetup() {
        
        var dataController: DataController { return AppShared.instances.dataController }
        
        
        XCTAssertNotNil(dataController.managedObjectContext)
        XCTAssertTrue(dataController.wasInitialised())
    }
    
    func testMapSingleCity() {
        
        let exp = expectation(description: "JSON converted to CoreCity successfully")
        
        DispatchQueue.global().async {
            
            let jsonResult = self.loadJson(jsonFile: "SingleCity")
            XCTAssertNotNil(jsonResult, "Failed to load file")
            
            let object = CoreCity.cityFromJSON(jsonResult!)
            
            XCTAssertNotNil(object.id, "id shouldnt be nil")
            XCTAssertTrue(object.id?.intValue == 2643743, "id is incorrect")
            
            XCTAssertNotNil(object.name, "name shouldnt be nil")
            XCTAssertEqual(object.name, "London", "name is incorrect")
            
            XCTAssertNotNil(object.country, "country shouldnt be nil")
            XCTAssertEqual(object.country, "GB", "country is incorrect")
            
            XCTAssertNotNil(object.lon, "lon shouldnt be nil")
            XCTAssertEqual(object.lon, -0.13, "lon is incorrect")
            
            XCTAssertNotNil(object.lat, "lat shouldnt be nil")
            XCTAssertEqual(object.lat, 51.51, "lat is incorrect")
            
            XCTAssertNotNil(object.deg, "deg shouldnt be nil")
            XCTAssertEqual(object.deg, 290, "deg is incorrect")
            
            XCTAssertNotNil(object.speed, "speed shouldnt be nil")
            XCTAssertEqual(object.speed,  1.5, "speed is incorrect")
            
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10.0) { (err) in
            XCTAssertNil(err)
        }
    }
    
    func testMapSeveralCity() {
        
        let exp = expectation(description: "JSON converted several CoreCity objects successfully")
        
        DispatchQueue.global().async {
            
            let jsonResult = self.loadJson(jsonFile: "SeveralCities")
            XCTAssertNotNil(jsonResult, "Failed to load file")
            
            let list = jsonResult!["list"] as? [[String : Any]]
            XCTAssertNotNil(list, "List of cities cannot be extracted")
            
            let count = jsonResult!["cnt"] as? Int
            XCTAssertNotNil(count, "Count cannot be extracted")
            
            XCTAssertTrue(list!.count == count!, "List elements count doesnt match count variable")
            
            let idsToCompare: [NSNumber] = [524901, 703448, 2643743]
            
            for (idx, json) in list!.enumerated() {
                
                let object = CoreCity.cityFromJSON(json)
                
                XCTAssertNotNil(object.id, "id shouldnt be nil")
                XCTAssertEqual(object.id, idsToCompare[idx], "id shouldnt be nil")
            }
            
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10.0) { (err) in
            XCTAssertNil(err)
        }
    }
    

    func testMapForecast() {
        
        let exp = expectation(description: "JSON converted to Forecast successfully")
        
        DispatchQueue.global().async {
            
            let jsonResult = self.loadJson(jsonFile: "Forecast")
            XCTAssertNotNil(jsonResult, "Failed to load file")
            
            let list = jsonResult!["list"] as? [[String : Any]]
            XCTAssertNotNil(list, "List of cities cannot be extracted")
            
            let count = jsonResult!["cnt"] as? Int
            XCTAssertNotNil(count, "Count cannot be extracted")
            
            XCTAssertTrue(list!.count == count!, "List elements count doesnt match count variable")
            
            if let json = jsonResult {
                let forecast = Forecast(json: json)
                XCTAssertEqual(forecast.id, 524901)
                exp.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10.0) { (err) in
            XCTAssertNil(err)
        }
    }
}
