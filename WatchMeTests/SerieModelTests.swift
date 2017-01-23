//
//  SerieModelTests.swift
//  WatchMe
//
//  Created by Felipe Silva  on 1/23/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import XCTest
@testable import WatchMe

class SerieModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSerieUpdate() {
        
        let wait = expectation(description: "nt")
        
        SerieRepository.nextTrending { series in
            
            if let serie = series?.first{
                serie.update(value: true, key: "watching")
                serie.update(value: false, key: "watching")
                serie.remove()
            }
            
            XCTAssertNotNil(series)
            wait.fulfill()
        }
        waitForExpectations(timeout: 4.0, handler: nil)
    }
    
    func testSerieAddRemoveEpisode() {
        
        let wait = expectation(description: "saddrm")
        
        SerieRepository.searchSeries(text: "oa") { series in
            
            if let serie = series?.first{
                
                EpisodeRepository.getEpisodeDetail(slug: "the-oa", season: 1, episode: 1) { episode in
                    
                    if let episode = episode{
                        serie.addEpisode(episode: episode)
                        serie.removeEpisode(episode: episode)
                        serie.addEpisode(episode: episode)
                        
                        if let serie = SerieRepository.getLocal(slug: "the-oa") {
                            serie.remove()
                        }
                    }
                    
                    wait.fulfill()
                }
                
            }
            
        }
                
        waitForExpectations(timeout: 6.0, handler: nil)
    }
        
}
