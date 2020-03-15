//
//  ERCurrencyExchangeServiceTests.swift
//  ExchangeRatesTests
//
//  Created by Ignacio on 15/03/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import XCTest
@testable import ExchangeRates

class ERCurrencyExchangeServiceTests: XCTestCase {
    
    var exchangeService: ERCurrencyExchangeService!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRequestWithExpectation() {
        exchangeService = ERCurrencyExchangeService()
        let expect = expectation(description: "Download should succeed")
        
        if let url = URL(string: "https://europe-west1-revolut-230009.cloudfunctions.net/revolut-ios") {
            exchangeService.getCurrencyExchange(url) { (response, error) in
                XCTAssertNil(error, "Error occured")
                XCTAssertNotNil(response, "No response")
                
                expect.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10) { (error) in
            XCTAssertNil(error, "Test timed out")
        }
    }

}
