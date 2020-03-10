//
//  ERInitialViewController.swift
//  ExchangeRates
//
//  Created by Ignacio on 07/03/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import UIKit

class ERInitialViewController: UIViewController {
    
    let kCurrenciesPairs = "currenciesPairs"
    let kCurrencyPair = "currencyPair"

    let kCurrenciesSelectedNotification = "CurrenciesSelected"
    var currencyPair: String = ""
    var currencyPairArray: [Any] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        currencyPairArray = UserDefaults.standard.array(forKey: kCurrenciesPairs) ?? []
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.requestCurrencyExchange), name:NSNotification.Name(rawValue: kCurrenciesSelectedNotification), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        if currencyPairArray.count > 0 {
            performSegue(withIdentifier: "InitialViewToExchangeListSegue", sender: nil)
        }
    }
    
    @objc func requestCurrencyExchange(_ notification: NSNotification)
    {
        if let pair = notification.userInfo?[kCurrencyPair] as? String {
            currencyPairArray.append(pair)
            UserDefaults.standard.set(currencyPairArray, forKey: kCurrenciesPairs)

            print("Request with pairs: ")
            print(currencyPairArray)
        
            print("///////////////////")

            performSegue(withIdentifier: "InitialViewToExchangeListSegue", sender: nil)

        }
        
        
        
        
        
    }
    
}
