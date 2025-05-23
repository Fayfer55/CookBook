//
//  MainViewControllerUITests.swift
//  MainViewControllerUITests
//
//  Created by Kirill Faifer on 25.03.2025.
//

import XCTest
@testable import CookBook

final class MainViewControllerUITests: XCTestCase {
    
    @MainActor
    private lazy var app: XCUIApplication = {
        let app = XCUIApplication()
        app.launchEnvironment["TEST"] = "1"
        return app
    }()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testEmptyStateOnMainViewController() throws {
        app.launch()
        
        let emptyLabel = app.staticTexts[MainViewController.Accessibility.emptyLabelIdentifier]
        
        XCTAssertTrue(emptyLabel.waitForExistence(timeout: 2), "Label doesn't exist")
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
