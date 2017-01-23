//
//  WatchMeUITests.swift
//  WatchMeUITests
//
//  Created by Felipe Silva  on 1/19/17.
//  Copyright © 2017 Felipe Silva . All rights reserved.
//

import XCTest
@testable import WatchMe

class WatchMeUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUI() {
        
        var app = XCUIApplication()
        
        sleep(3)
        
        app = testDiscoverVC(app: app)
        
        sleep(3)
        
        app = testSearchVC(app: app)
        
        sleep(1)
        
        app = testDetailSerieVC(app: app)
        
        sleep(3)
        
        app = testSeaonsSerieVC(app: app)
        
        sleep(1)
        
        app = testProfileVC(app: app)

        sleep(1)
        
        app = testWatchingVC(app: app)

    }
    
    private func testDiscoverVC(app : XCUIApplication) -> XCUIApplication{
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.swipeUp()
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.swipeUp()
        
        
        app.navigationBars["Trending"].buttons["Search"].tap()
        app.searchFields["Search Series"].typeText("house")
        app.keyboards.buttons["Search"].tap()

        return app
    }
    
    private func testSearchVC(app : XCUIApplication) -> XCUIApplication{
                
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.swipeUp()
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.swipeUp()
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.swipeDown()
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.swipeDown()

        app.collectionViews.cells.element(boundBy: 1).tap()
        
        return app
    }
    
    private func testDetailSerieVC(app : XCUIApplication)-> XCUIApplication{
        
        app.tables.cells.element(boundBy: 3).tap()
        
        return app
    }
    
    private func testSeaonsSerieVC(app : XCUIApplication)-> XCUIApplication{
        
        
        app.tables.cells.element(boundBy: 0).buttons["watching icon"].tap()
        app.tables.cells.element(boundBy: 0).buttons["nowatching icon"].tap()
        app.tables.cells.element(boundBy: 0).buttons["watching icon"].tap()

        
        app.tables.cells.element(boundBy: 0).tap()
        
        return app
    }
    
    private func testWatchingVC(app : XCUIApplication)-> XCUIApplication{
        
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Watching"].tap()

        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.swipeUp()
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.swipeDown()
        
        app.collectionViews.cells.element(boundBy: 0).tap()
        
        app.tables.cells.element(boundBy: 1).buttons["nowatching icon"].tap()
        
        
        return app
    }
    
    private func testProfileVC(app : XCUIApplication)-> XCUIApplication{
        
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Profile"].tap()
        
        app.navigationBars["WatchMe.ProfileView"].buttons["NextUp Episodes"].tap()

        sleep(2)
        
        app.tables.cells.element(boundBy: 0).tap()

        return app
    }
    
}
