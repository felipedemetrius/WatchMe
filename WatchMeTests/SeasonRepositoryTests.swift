//
//  SeasonRepositoryTests.swift
//  WatchMe
//
//  Created by Felipe Silva  on 1/23/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import XCTest
@testable import WatchMe

class SeasonRepositoryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetSeasons() {
        let wait = expectation(description: "seasons")
        
        SeasonRepository.getSeasons(slug: "the-oa") { seasons in
            
            XCTAssertNotNil(seasons)
            wait.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    
}
