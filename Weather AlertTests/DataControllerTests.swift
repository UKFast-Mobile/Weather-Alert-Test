//
//  DataControllerTests.swift
//  Weather Alert
//
//  Created by Aleksandr Kelbas on 10/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import XCTest
import CoreData
@testable import Weather_Alert

class DataControllerTests: XCTestCase {
    
    let dataController = DataController()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testDataControllerSetup() {
        
        let dataController = DataController()
        
        
        XCTAssertNotNil(dataController.managedObjectContext)
        XCTAssertTrue(dataController.wasInitialised())
    }
    
    func testMapForecast() {
        
        let exp = expectation(description: "JSON converted to object successfully")
        
        DispatchQueue.global().async {
            
            let jsonResult = self.loadJson(jsonFile: "Forecast")
            XCTAssertNotNil(jsonResult, "Failed to load file")
            
            let list = jsonResult!["list"] as? [[String : Any]]
            XCTAssertNotNil(list, "List of cities cannot be extracted")
            
            let count = jsonResult!["cnt"] as? Int
            XCTAssertNotNil(count, "Count cannot be extracted")
            
            XCTAssertTrue(list!.count == count!, "List elements count doesnt match count variable")
            
            for (idx, _) in list!.enumerated() {
                
                let entity: NSEntityDescription? = NSEntityDescription.entity(forEntityName: "Forecast", in: self.dataController.managedObjectContext)
                XCTAssertNotNil(entity, "Entity could not be found")
                
                let object = Forecast(entity: entity!, insertInto: self.dataController.managedObjectContext)
                
                object.mapping(json: jsonResult!, count: idx)
                
                XCTAssertNotNil(object.id, "id shouldnt be nil")
            }
            
            exp.fulfill()
            
        }
        
        waitForExpectations(timeout: 10.0) { (err) in
            XCTAssertNil(err)
        }
    }
    
}
