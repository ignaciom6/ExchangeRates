//
//  ERCurrencyExchangeManager.swift
//  ExchangeRates
//
//  Created by Ignacio on 11/03/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import UIKit

class ERCurrencyExchangeManager: NSObject {
    
    func getCurrencyExchange(_ url: URL, withCompletion completion: @escaping (_ value: [String : Any]?, _ error: Error?) -> Void) {
        let currencyExchangeService = ERCurrencyExchangeService()
        currencyExchangeService.getCurrencyExchange(url) { (value, error) in
            if value != nil {
                completion(value, nil)
            } else {
                completion(nil, error!)
            }
        }
    }

}
