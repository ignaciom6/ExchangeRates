//
//  ERCurrencyExchangeService.swift
//  ExchangeRates
//
//  Created by Ignacio on 11/03/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import UIKit

class ERCurrencyExchangeService: NSObject {
    
    func getCurrencyExchange(_ url: URL, withCompletion completion: @escaping (_ value: [String : Any]?, _ error: Error?) -> Void) {
        var exchangeDic: [String : Any]?
        
        let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil {
                do {
                    exchangeDic = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
                } catch {
                    
                }
                completion(exchangeDic, error)
            } else {
                completion(nil, error)
            }
        }
        session.resume()
        
    }

}
