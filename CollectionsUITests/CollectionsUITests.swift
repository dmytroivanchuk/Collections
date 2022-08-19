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
        staticText["Insert 1000 elements in the middle of the array one-by-one."].tap()
        staticText["Insert 1000 elements in the middle of the array at once."].tap()
        staticText["Insert 1000 elements at the end of the array one-by-one."].tap()
        staticText["Insert 1000 elements at the end of the array at once."].tap()
        staticText["Remove 1000 elements at the beginning of the array one-by-one."].tap()
        staticText["Remove 1000 elements at the beginning of the array at once."].tap()
        staticText["Remove 1000 elements in the middle of the array one-by-one."].tap()
        staticText["Remove 1000 elements in the middle of the array at once."].tap()
        staticText["Remove 1000 elements at the end of the array one-by-one."].tap()
        staticText["Remove 1000 elements at the end of the array at once."].tap()
        
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
    
    func testSetFeature_withAllButtonsPressed_shouldExecuteAllOperations() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Set"].tap()
        
        app.textFields["firstTextField"].tap()
        app.textFields["firstTextField"].typeText("ab123")
        
        app.textFields["secondTextField"].tap()
        app.textFields["secondTextField"].typeText("123ac")
        
        app.staticTexts["All matching letters"].tap()
        app.staticTexts["All characters that do not match"].tap()
        app.staticTexts["All unique characters from the first text field that do not match in text fields"].tap()
        
        app.staticTexts["a"].tap()
        
        XCTAssert(app.staticTexts["a"].exists)
        XCTAssert(app.staticTexts["b"].exists || app.staticTexts["c"].exists)
        XCTAssert(app.staticTexts["b"].exists)
    }
    
    func testDictionaryFeature_withAllOperationCellPressed_shouldExecuteAllOperations() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.tables.staticTexts["Dictionary"].tap()
        sleep(10)
        
        let staticText = app.collectionViews.staticTexts
        XCTAssert(staticText["Find the first contact"].exists)
        XCTAssert(staticText["Find the last contact"].exists)
        XCTAssert(staticText["Find the non-existing element"].exists)
        
        app.collectionViews.children(matching: .cell).element(boundBy: 2).staticTexts["Find the first contact"].tap()
        
        let predicate = NSPredicate(format: "label CONTAINS 'Result number: 0'")
        let element = app.staticTexts.element(matching: predicate)
        XCTAssert(element.exists)
        element.tap()
        XCTAssert(element.exists)
        
        staticText["Find the first contact"].tap()
        app.collectionViews.children(matching: .cell).element(boundBy: 4).staticTexts["Find the last contact"].tap()
        staticText["Find the last contact"].tap()
        app.collectionViews.children(matching: .cell).element(boundBy: 6).staticTexts["Find the non-existing element"].tap()
        staticText["Find the non-existing element"].tap()
        
        XCTAssert(!staticText["Find the first contact"].exists)
        XCTAssert(!staticText["Find the last contact"].exists)
        XCTAssert(!staticText["Find the non-existing element"].exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
