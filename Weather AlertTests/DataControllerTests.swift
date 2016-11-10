//
//  DataControllerTests.swift
//  Weather Alert
//
//  Created by Aleksandr Kelbas on 10/11/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import XCTest
@testable import Weather_Alert

class DataControllerTests: XCTestCase {
    
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
        
        XCTAssertNotNil(dataController.applicationDocumentsDirectory)
        XCTAssertNotNil(dataController.managedObjectModel)
        XCTAssertNotNil(dataController.managedObjectContext)
        XCTAssertNotNil(dataController.persistentStoreCoordinator)
    }
    
}
