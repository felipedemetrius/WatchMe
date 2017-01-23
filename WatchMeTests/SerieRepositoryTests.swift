//
//  SerieRepositoryTests.swift
//  WatchMe
//
//  Created by Felipe Silva  on 1/23/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import XCTest
@testable import WatchMe

class SerieRepositoryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetTrendingSeries() {
        
        let wait = expectation(description: "trending")
        SerieRepository.getSeriesTrending { [weak self] series in
            XCTAssertNotNil(series)
            wait.fulfill()
        }
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testSearchSeries() {
        
        let wait = expectation(description: "search")
        
        SerieRepository.searchSeries(text: "new") { [weak self] series in
            
            XCTAssertNotNil(series)
            wait.fulfill()
        }
        waitForExpectations(timeout: 4.0, handler: nil)
    }

    func testNextTrending() {
        
        let wait = expectation(description: "nt")
        
        SerieRepository.nextTrending { series in
            
            XCTAssertNotNil(series)
            wait.fulfill()
        }
        waitForExpectations(timeout: 4.0, handler: nil)
    }

    func testNextSearch() {
        
        let wait = expectation(description: "ns")
        
        SerieRepository.nextSearch(text: "oa", completionHandler: { series in
            XCTAssertNotNil(series)
            wait.fulfill()
        })
            
        waitForExpectations(timeout: 4.0, handler: nil)
    }
    
    func testGetLocal(){
        XCTAssertNil(SerieRepository.getLocal(slug: "test"))
    }

    func testWatching(){
        XCTAssertNotNil(SerieRepository.getWatching())
    }
    
    func testGetSlugs(){
        XCTAssertNil(SerieRepository.getSlugsLocal())
    }
    
    func testSeriesWithEpisodes(){
        XCTAssertNotNil(SerieRepository.getSeriesWithEpisodes())
    }
    
    func testGetEpisodeWatched(){
        XCTAssertNil(SerieRepository.getEpisodeWatched(slug: "test", target: "test"))
    }
    
}
