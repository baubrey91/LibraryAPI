//
//  iOSTechTestUITests.swift
//  iOSTechTestUITests
//
//  Created by Stone Zhang on 2023/11/26.
//

import XCTest


/// UITest is very simple run through of app. Lots of remove for improvement here

final class iOSTechTestUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testUIRunThrough() {
        let searchField = app.searchFields["Search by subject"]
        
        // Check for search bar
        XCTAssertTrue(searchField.waitForExistence(timeout: 5), "Search field should exist.")
        
        // Create Search
        searchField.tap()
        searchField.typeText("horror")
        searchField.typeText("\n")
        
        // Check for results (This required network connections
        let firstResult = app.staticTexts.element(boundBy: 0) // This assumes the list items are static text
        
        XCTAssertTrue(firstResult.exists, "First result should be visible.")
        
        // Click on first result
        firstResult.tap()
        let subTitle = app.staticTexts["Tap to see details..."]
        
        
        // Check if we are in detail view
        XCTAssertTrue(subTitle.waitForExistence(timeout: 5), "Should be in detail view")
        
        // Click on detail view
        app.tap()
        
        
        // Check if we are in details card
        let detailCard = app.staticTexts["detailCardTitle"]
        XCTAssertTrue(detailCard.waitForExistence(timeout: 5), "Should be in detail view")
    }
}
