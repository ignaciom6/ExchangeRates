//
//  ERExchangeListViewController.swift
//  ExchangeRates
//
//  Created by Ignacio on 10/03/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import UIKit

class ERExchangeListViewController: UIViewController {
    let kCurrenciesPairs = "currenciesPairs"
    let urlComponents = NSURLComponents(string: "https://europe-west1-revolut-230009.cloudfunctions.net/revolut-ios")

    var timer = Timer()
    let currencyExchangeManager = ERCurrencyExchangeManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestExchangeRatesWithInterval()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        timer.invalidate()
    }
    
    func requestExchangeRatesWithInterval()
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.requestExchangeRates), userInfo: nil, repeats: true)
    }
    
    @objc func requestExchangeRates()
    {
        let currencyPairArray = UserDefaults.standard.array(forKey: kCurrenciesPairs) ?? []
        var queryItems: [URLQueryItem] = []
        
        for pair in currencyPairArray {
            let queryItem = NSURLQueryItem(name: "pairs", value: pair as? String) as URLQueryItem
            queryItems.append(queryItem)
        }
        
        urlComponents?.queryItems = queryItems

        print(urlComponents?.url ?? "")
        
        currencyExchangeManager.getCurrencyExchange((urlComponents?.url)!) { (value, error) in
            print(value ?? "")
        }
    }

    
}
