//
//  ERInitialViewController.swift
//  ExchangeRates
//
//  Created by Ignacio on 07/03/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import UIKit

class ERInitialViewController: UIViewController {
    
    var currencyPair: String = ""
    var currencyPairArray: [Any] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.requestCurrencyExchange), name:NSNotification.Name(rawValue: ERConstants.kCurrenciesSelectedNotification), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        currencyPairArray = UserDefaults.standard.array(forKey: ERConstants.kCurrenciesPairs) ?? []
        
        if currencyPairArray.count > 0 {
            performSegue(withIdentifier: ERConstants.kInitialViewToExchangeListSegue, sender: nil)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func requestCurrencyExchange(_ notification: NSNotification)
    {
        if let pair = notification.userInfo?[ERConstants.kCurrencyPair] as? String {
            currencyPairArray.append(pair)
            UserDefaults.standard.set(currencyPairArray, forKey: ERConstants.kCurrenciesPairs)

            performSegue(withIdentifier: ERConstants.kInitialViewToExchangeListSegue, sender: nil)

        }
        
    }
    
}
