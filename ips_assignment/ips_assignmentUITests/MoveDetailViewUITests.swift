//
//  MoveDetailViewUITests.swift
//  ips_assignmentUITests
//
//  Created by Loyd Kim on 2023-02-11.
//

import XCTest

final class MoveDetailViewUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMoveDetailView() throws {
        let app = XCUIApplication()
        app.launch()
        print(app.debugDescription)
        let collectionView = app.collectionViews.element(boundBy: 0)
        XCTAssertTrue(collectionView.exists)
            
        let cell = collectionView.cells.element(boundBy: 0)
        XCTAssertTrue(cell.exists)
        
        cell.tap()
            
        let appNavigationBarBackButton = app.navigationBars.buttons["Lessons"]
        XCTAssertTrue(appNavigationBarBackButton.exists)
        
        appNavigationBarBackButton.tap()
        
        let cell2 = collectionView.cells.element(boundBy: 1)
        XCTAssertTrue(cell2.exists)

        cell2.tap()
        
        // Try to download the movie and cancel download
        
        let downloadButton = app.navigationBars.buttons["  Download"]
        XCTAssertTrue(downloadButton.exists)

        downloadButton.tap()

        let cancelDownload = app.buttons["Cancel download"]
        XCTAssertTrue(cancelDownload.exists)

        cancelDownload.tap()

        appNavigationBarBackButton.tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
