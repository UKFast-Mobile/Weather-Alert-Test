//
//  NetworkingTests.swift
//  Weather Alert
//
//  Created by Jack Hopkins on 05/12/2016.
//  Copyright © 2016 UKFast. All rights reserved.
//

import XCTest
@testable import Weather_Alert

class NetworkingTests: XCTestCase {
    
    let networking = AppShared.instances.networking
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testForecastRequest() {
        let exp = expectation(description: "Forecast request failed")
        
        let request = ForecastRequest(cityId: 524901)
        
        networking.sendRequest(request) { response, err in
            if let json = response {
                XCTAssertEqual(json["cnt"] as! Int , 7)

                print(json["cnt"] as Any)
                print(json)
                exp.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10.0) { (err) in
            XCTAssertNil(err)
        }
    }
}
