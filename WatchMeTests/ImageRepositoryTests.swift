//
//  ImageRepositoryTests.swift
//  WatchMe
//
//  Created by Felipe Silva  on 1/23/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import XCTest
@testable import WatchMe

class ImageRepositoryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetImage() {
        let wait = expectation(description: "image")
        ImageRepository.getImage(imdb: "tt1480055") { [weak self] result in
            XCTAssertNotNil(result)
            wait.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
        
}
