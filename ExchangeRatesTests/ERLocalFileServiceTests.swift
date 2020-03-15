//
//  ERLocalFileServiceTests.swift
//  ExchangeRatesTests
//
//  Created by Ignacio on 15/03/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import XCTest
@testable import ExchangeRates

class ERLocalFileServiceTests: XCTestCase {

    var localFileService: ERLocalFileService!

    func testFileExists() {
        XCTAssert(ERConstants.kCurrenciesFile == "currencies", "File not found: \(ERConstants.kCurrenciesFile)")
        guard let currenciesURL = Bundle.main.path(forResource: ERConstants.kCurrenciesFile, ofType: ERConstants.kJsonType) else {
            return
        }
        XCTAssertNotNil(FileManager.default.fileExists(atPath: currenciesURL))
    }
    
    func testRequestFileWithExpectation() {
        localFileService = ERLocalFileService()
        let expect = expectation(description: "Get file should succeed")
        
        localFileService.getDataFromFile(ERConstants.kCurrenciesFile, type: ERConstants.kJsonType) { (response, error) in
            XCTAssertNil(error, "Error occured")
            XCTAssertNotNil(response, "No response")
            
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            XCTAssertNil(error, "Test timed out")
        }
    }

}
