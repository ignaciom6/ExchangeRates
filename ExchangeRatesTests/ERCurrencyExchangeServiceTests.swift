//
//  ERCurrencyExchangeServiceTests.swift
//  ExchangeRatesTests
//
//  Created by Ignacio on 14/03/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import XCTest

class ERCurrencyExchangeServiceTests: XCTestCase {
    
    var httpClient: HttpClient!
    let session = MockURLSession()
    
    override func setUp() {
        super.setUp()
        httpClient = HttpClient(session: session)
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
