//
//  ERCurrenciesViewControllerTests.swift
//  ExchangeRatesTests
//
//  Created by Ignacio on 14/03/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import XCTest
@testable import ExchangeRates

class ERCurrenciesViewControllerTests: XCTestCase {

    var currenciesViewController: ERCurrenciesViewController!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        self.currenciesViewController = storyboard.instantiateViewController(withIdentifier: "CurrenciesViewController") as? ERCurrenciesViewController
        
        self.currenciesViewController.loadView()
        self.currenciesViewController.viewDidLoad()
    }

    func testHasATableView() {
        XCTAssertNotNil(currenciesViewController.tableView)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(currenciesViewController.tableView.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(currenciesViewController.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(currenciesViewController.responds(to: #selector(currenciesViewController.tableView(_:didSelectRowAt:))))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(currenciesViewController.tableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(currenciesViewController.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(currenciesViewController.responds(to: #selector(currenciesViewController.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(currenciesViewController.responds(to: #selector(currenciesViewController.tableView(_:cellForRowAt:))))
    }

}
