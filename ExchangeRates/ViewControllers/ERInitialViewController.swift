//
//  ERInitialViewController.swift
//  ExchangeRates
//
//  Created by Ignacio on 07/03/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import UIKit

class ERInitialViewController: UIViewController {
    
    let kCurrenciesSelectedNotification = "CurrenciesSelected"
    var currencyPair: String = ""

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.requestCurrencyExchange), name:NSNotification.Name(rawValue: kCurrenciesSelectedNotification), object: nil)
    }
    
    @objc func requestCurrencyExchange()
    {
        print(currencyPair)
    }
    
}
