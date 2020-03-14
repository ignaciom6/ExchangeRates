//
//  ERExchangeModelTests.swift
//  ExchangeRatesTests
//
//  Created by Ignacio on 14/03/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import XCTest
@testable import ExchangeRates

class ERExchangeModelTests: XCTestCase {

    var exchangeModel: ERExchangeModel!
    var exchangeDict = (key: "BRLBGN", value: 0.4766)
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testModelInitialization() {
        exchangeModel = ERExchangeModel(dictionary: exchangeDict)
        
        XCTAssertEqual(exchangeModel.currency, "BRL")
        XCTAssertEqual(exchangeModel.currencyDetail, "Brazilian Real")
        XCTAssertEqual(exchangeModel.exchangeCurrencyDetail, "Bulgarian Lev · BGN")
        XCTAssertEqual(exchangeModel.exchangeValue, 0.4766)
        XCTAssertEqual(exchangeModel.exchange, "BGN")
    }

}
