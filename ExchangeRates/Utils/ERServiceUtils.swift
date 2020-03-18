//
//  ERServiceUtils.swift
//  ExchangeRates
//
//  Created by Ignacio on 14/03/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import UIKit

class ERServiceUtils: NSObject {

    class func getPairsUrl() -> URL {
        let urlComponents = NSURLComponents(string: "https://europe-west1-revolut-230009.cloudfunctions.net/revolut-ios")
        
        let currencyPairArray = ERUserDefaultsUtils.getStoredArray()
        var queryItems: [URLQueryItem] = []
        
        for pair in currencyPairArray {
            let queryItem = NSURLQueryItem(name: "pairs", value: pair) as URLQueryItem
            queryItems.append(queryItem)
        }
        urlComponents?.queryItems = queryItems
        
        return (urlComponents?.url)!
    }

}
