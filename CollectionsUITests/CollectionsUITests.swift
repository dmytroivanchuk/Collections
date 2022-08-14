//
//  CollectionsUITests.swift
//  CollectionsUITests
//
//  Created by Dmytro Ivanchuk on 12.08.2022.
//

import XCTest

class CollectionsUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testArrayFeature_withAllOperationCellPressed_shouldExecuteAllOperations() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Array"].tap()
        
        let staticText = app.collectionViews.staticTexts
        XCTAssert(staticText["Create Int array with 10_000_000 elements"].exists)
        
        staticText["Create Int array with 10_000_000 elements"].tap()
        sleep(3)
        
        var predicate = NSPredicate(format: "label BEGINSWITH 'Array generation time:'")
        var element = app.staticTexts.element(matching: predicate)
        XCTAssert(element.exists)
        element.tap()
        XCTAssert(element.exists)
        
        XCTAssert(staticText["Insert 1000 elements at the beginning of the array one-by-one."].exists)
        XCTAssert(staticText["Insert 1000 elements at the beginning of the array at once."].exists)
        XCTAssert(staticText["Insert 1000 elements in the middle of the array one-by-one."].exists)
        XCTAssert(staticText["Insert 1000 elements in the middle of the array at once."].exists)
        XCTAssert(staticText["Insert 1000 elements at the end of the array one-by-one."].exists)
        XCTAssert(staticText["Insert 1000 elements at the end of the array at once."].exists)
        XCTAssert(staticText["Remove 1000 elements at the beginning of the array one-by-one."].exists)
        XCTAssert(staticText["Remove 1000 elements at the beginning of the array at once."].exists)
        XCTAssert(staticText["Remove 1000 elements in the middle of the array one-by-one."].exists)
        XCTAssert(staticText["Remove 1000 elements in the middle of the array at once."].exists)
        XCTAssert(staticText["Remove 1000 elements at the end of the array one-by-one."].exists)
        XCTAssert(staticText["Remove 1000 elements at the end of the array at once."].exists)
        
        staticText["Insert 1000 elements at the beginning of the array one-by-one."].tap()
        sleep(3)
        
        predicate = NSPredicate(format: "label BEGINSWITH 'Execution time:'")
        element = app.staticTexts.element(matching: predicate)
        XCTAssert(element.exists)
        element.tap()
        XCTAssert(element.exists)
        
        staticText["Insert 1000 elements at the beginning of the array at once."].tap()
        sleep(3)
        staticText["Insert 1000 elements in the middle of the array one-by-one."].tap()
        sleep(3)
        staticText["Insert 1000 elements in the middle of the array at once."].tap()
        sleep(3)
        staticText["Insert 1000 elements at the end of the array one-by-one."].tap()
        sleep(3)
        staticText["Insert 1000 elements at the end of the array at once."].tap()
        sleep(3)
        staticText["Remove 1000 elements at the beginning of the array one-by-one."].tap()
        sleep(3)
        staticText["Remove 1000 elements at the beginning of the array at once."].tap()
        sleep(3)
        staticText["Remove 1000 elements in the middle of the array one-by-one."].tap()
        sleep(3)
        staticText["Remove 1000 elements in the middle of the array at once."].tap()
        sleep(3)
        staticText["Remove 1000 elements at the end of the array one-by-one."].tap()
        sleep(3)
        staticText["Remove 1000 elements at the end of the array at once."].tap()
        sleep(3)
        
        XCTAssert(!staticText["Insert 1000 elements at the beginning of the array one-by-one."].exists)
        XCTAssert(!staticText["Insert 1000 elements at the beginning of the array at once."].exists)
        XCTAssert(!staticText["Insert 1000 elements in the middle of the array one-by-one."].exists)
        XCTAssert(!staticText["Insert 1000 elements in the middle of the array at once."].exists)
        XCTAssert(!staticText["Insert 1000 elements at the end of the array one-by-one."].exists)
        XCTAssert(!staticText["Insert 1000 elements at the end of the array at once."].exists)
        XCTAssert(!staticText["Remove 1000 elements at the beginning of the array one-by-one."].exists)
        XCTAssert(!staticText["Remove 1000 elements at the beginning of the array at once."].exists)
        XCTAssert(!staticText["Remove 1000 elements in the middle of the array one-by-one."].exists)
        XCTAssert(!staticText["Remove 1000 elements in the middle of the array at once."].exists)
        XCTAssert(!staticText["Remove 1000 elements at the end of the array one-by-one."].exists)
        XCTAssert(!staticText["Remove 1000 elements at the end of the array at once."].exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
