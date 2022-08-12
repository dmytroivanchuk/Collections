//
//  ArrayProcessingModelUnitTests.swift
//  ArrayProcessingModelUnitTests
//
//  Created by Dmytro Ivanchuk on 12.08.2022.
//

import XCTest
@testable import Collections

class ArrayProcessingModelUnitTests: XCTestCase {
    
    var arrayProcessingModel: ArrayProcessingModel!
    
    override func setUpWithError() throws {
        arrayProcessingModel = ArrayProcessingModel()
    }

    override func tearDownWithError() throws {
        arrayProcessingModel = nil
    }

    func test_generateArray_withCompletionHandler_shouldChangeArrayGenerationStatusAndCallCompletionHandler() throws {
        let expectation = XCTestExpectation(description: "Generate array on background thread")
        var testCompletionHandlerExecution = false
        
        arrayProcessingModel.generateArray {
            testCompletionHandlerExecution = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            XCTAssertNotEqual(self.arrayProcessingModel.arrayGenerationStatus, OperationStatus.idle)
            XCTAssertNotEqual(self.arrayProcessingModel.arrayGenerationStatus, OperationStatus.executing)
            XCTAssertEqual(self.arrayProcessingModel.array.count, 10_000_000)
            XCTAssert(testCompletionHandlerExecution)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test_executeOperation_withCompletionHandler_shouldChangeOperationStatusAndCallCompletionHandler() throws {
        let expectation = XCTestExpectation(description: "Execute operation on background thread")
        var testCompletionHandlerExecution = false
        
        let testOperation = Operation(description: "Insert 500 elements at the end of the array one-by-one.", closureToExecute: {
            var newArray = $0
            for int in 0 ..< 500 {
                newArray.append(int)
            }
        })
        
        arrayProcessingModel.executeOperation(testOperation) {
            testCompletionHandlerExecution = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            XCTAssertNotEqual(testOperation.status, OperationStatus.idle)
            XCTAssertNotEqual(testOperation.status, OperationStatus.executing)
            XCTAssert(testCompletionHandlerExecution)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 4)
    }
}
