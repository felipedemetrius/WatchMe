//
//  EpisodeRepositoryTests.swift
//  WatchMe
//
//  Created by Felipe Silva  on 1/23/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import XCTest
@testable import WatchMe

class EpisodeRepositoryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetNextEpisode() {
        
        let wait = expectation(description: "ne")
        
        EpisodeRepository.getNextEpisode(slug: "the-oa") { episode in
            
            if let episode = episode {
                XCTAssertNotNil(episode)
            } else {
                XCTAssertNil(episode)
            }
            wait.fulfill()
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testGetEpisodeDetail(){
        
        let wait = expectation(description: "epdt")
        
        EpisodeRepository.getEpisodeDetail(slug: "the-oa", season: 1, episode: 1) { episode in
            
            if let episode = episode {
                let target = episode.target
                XCTAssertNotNil(episode)
                XCTAssertNotNil(target)
            }
            
            wait.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testGetLocal(){
        XCTAssertNil(EpisodeRepository.getLocal(tvdb: 111))
    }

    
}
