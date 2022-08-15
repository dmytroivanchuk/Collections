//
//  SetProcessingModelUnitTests.swift
//  CollectionsUnitTests
//
//  Created by Dmytro Ivanchuk on 16.08.2022.
//

import XCTest
@testable import Collections

class SetProcessingModelUnitTests: XCTestCase {
    
    var setProcessingModel: SetProcessingModel!
    
    override func setUpWithError() throws {
        setProcessingModel = SetProcessingModel()
    }

    override func tearDownWithError() throws {
        setProcessingModel = nil
    }

    func test_executeOperation_withMatchingCharactersIdentifier_shouldReturnMatchingCharacters() throws {
        let result = setProcessingModel.executeOperation(withIdentifier: "matchingCharacters", "Qwerty", "Qazr")
        XCTAssertEqual(CharacterSet(charactersIn: result), CharacterSet(charactersIn: "Qr"))
    }
    
    func test_executeOperation_withNonMatchingCharactersIdentifier_shouldReturnNonMatchingCharacters() throws {
        let result = setProcessingModel.executeOperation(withIdentifier: "nonMatchingCharacters", "Qwerty", "Qazr")
        XCTAssertEqual(CharacterSet(charactersIn: result), CharacterSet(charactersIn: "tzweay"))
    }
    
    func test_executeOperation_withUniqueCharactersIdentifier_shouldReturnUniqueCharacters() throws {
        let result = setProcessingModel.executeOperation(withIdentifier: "uniqueCharacters", "Qwerty", "Qazr")
        XCTAssertEqual(CharacterSet(charactersIn: result), CharacterSet(charactersIn: "ytew"))
    }
    
    func test_executeOperation_withInvalidIdentifier_shouldReturnNothing() throws {
        let result = setProcessingModel.executeOperation(withIdentifier: "atchingCharacters", "Qwerty", "Qazr")
        XCTAssertEqual(result, "")
    }
    
    func test_executeOperation_withNilInput_shouldReturnNothing() throws {
        let result = setProcessingModel.executeOperation(withIdentifier: "matchingCharacters", nil, nil)
        XCTAssertEqual(result, "")
    }
}
