//
//  ERExchangeModel.swift
//  ExchangeRates
//
//  Created by Ignacio on 13/03/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import UIKit

class ERExchangeModel: NSObject {
    
    var currency: String?
    var currencyDetail: String?
    var exchangeCurrencyDetail: String?
    var exchangeValue: Double?
    var exchange: String?
    
    init(dictionary: (key: String, value: Any)) {
        super.init()
            currency = dictionary.key[0..<3]
            currencyDetail = ERCurrencyUtils.getCurrencyName(forCurrencyCode: currency!)
            exchangeCurrencyDetail = composedDetailedCurrency(currencyCode: dictionary.key[3..<6])
            exchangeValue = dictionary.value as? Double
            exchange = dictionary.key[3..<6]
    }

    func composedDetailedCurrency(currencyCode: String) -> String {
        return ERCurrencyUtils.getCurrencyName(forCurrencyCode: currencyCode)! + " · " + currencyCode
    }
}

extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
