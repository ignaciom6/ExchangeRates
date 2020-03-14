//
//  ERExchangeListViewControllerTests.swift
//  ExchangeRatesTests
//
//  Created by Ignacio on 14/03/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import XCTest
@testable import ExchangeRates

class ERExchangeListViewControllerTests: XCTestCase {

    var exchangeViewController: ERExchangeListViewController!

    override func setUp() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        self.exchangeViewController = storyboard.instantiateViewController(withIdentifier: "ExchangeViewController") as? ERExchangeListViewController
        
        self.exchangeViewController.loadView()
        self.exchangeViewController.viewDidLoad()

    }
    
    func testHasATableView() {
        XCTAssertNotNil(exchangeViewController.tableView)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(exchangeViewController.tableView.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(exchangeViewController.conforms(to: UITableViewDelegate.self))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(exchangeViewController.tableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(exchangeViewController.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(exchangeViewController.responds(to: #selector(exchangeViewController.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(exchangeViewController.responds(to: #selector(exchangeViewController.tableView(_:cellForRowAt:))))
    }

}
