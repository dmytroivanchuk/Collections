//
//  DictionaryProcessingModelUnitTests.swift
//  CollectionsUnitTests
//
//  Created by Dmytro Ivanchuk on 19.08.2022.
//

import XCTest
@testable import Collections

class DictionaryProcessingModelUnitTests: XCTestCase {

    var dictionaryProcessingModel: DictionaryProcessingModel!
    
    override func setUpWithError() throws {
        dictionaryProcessingModel = DictionaryProcessingModel()
    }

    override func tearDownWithError() throws {
        dictionaryProcessingModel = nil
    }

    func test_generateDictionaryArray_withCompletionHandler_shouldChangeDictionaryGenerationStatusAndCallCompletionHandler() throws {
        let expectation = XCTestExpectation(description: "Generate dictionary and array on background thread")
        var testCompletionHandlerExecution = false
        
        dictionaryProcessingModel.generateDictionaryArray {
            testCompletionHandlerExecution = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            XCTAssertNotEqual(self.dictionaryProcessingModel.dictionaryGenerationStatus, DictionaryOperationStatus.idle)
            XCTAssertNotEqual(self.dictionaryProcessingModel.dictionaryGenerationStatus, DictionaryOperationStatus.executing)
            XCTAssertEqual(self.dictionaryProcessingModel.dictionary.count, 10_000_000)
            XCTAssertEqual(self.dictionaryProcessingModel.array.count, 10_000_000)
            XCTAssert(testCompletionHandlerExecution)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 12)
    }
    
    func test_executeOperation_withCompletionHandler_shouldChangeDictionaryOperationStatusAndCallCompletionHandler() throws {
        let expectation = XCTestExpectation(description: "Execute operation on background thread")
        var testCompletionHandlerExecution = false
        
        let testOperation = DictionaryOperation(description: "Find the tenth contact", closureToExecute: { _, dictionary in
            dictionary["Name10"]
        })
        
        dictionaryProcessingModel.executeOperation(testOperation) {
            testCompletionHandlerExecution = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            XCTAssertNotEqual(testOperation.status, DictionaryOperationStatus.idle)
            XCTAssertNotEqual(testOperation.status, DictionaryOperationStatus.executing)
            XCTAssert(testCompletionHandlerExecution)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 4)
    }
}
