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

    func testFileExists() {
        XCTAssert(ERConstants.kCurrenciesFile == "currencies", "File not found: \(ERConstants.kCurrenciesFile)")
        guard let currenciesURL = Bundle.main.path(forResource: ERConstants.kCurrenciesFile, ofType: ERConstants.kJsonType) else {
            return
        }
        XCTAssertNotNil(FileManager.default.fileExists(atPath: currenciesURL))
    }

}
