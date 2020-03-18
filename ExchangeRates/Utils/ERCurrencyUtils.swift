//
//  ERCurrencyUtils.swift
//  ExchangeRates
//
//  Created by Ignacio on 08/03/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import UIKit

class ERCurrencyUtils: NSObject {
    
    class func getCurrencyName(forCurrencyCode code: String) -> String? {
        let locale = NSLocale(localeIdentifier: code)
        return locale.localizedString(forCurrencyCode: code)
    }
    
    class func setAttributeTextForString(value: String) -> NSMutableAttributedString {
        let exchangeValueText = NSMutableAttributedString.init(string: value)
        
        exchangeValueText.setAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)], range: NSMakeRange(value.length-2, 2))

        return exchangeValueText
    }
    
    class func updateCurrencies(pair: String) {
        var currencyPairArray: [String] = ERUserDefaultsUtils.getStoredArray()
        if !currencyPairArray.contains(pair) {
            currencyPairArray.append(pair)
            ERUserDefaultsUtils.storeArray(currencyArray: currencyPairArray)
        }
    }
    
    class func sortExchangeModelArray(array: [ERExchangeModel]) -> Array<ERExchangeModel> {
        var sortedArray = array
        sortedArray.sort {
            $0.currency!+$0.exchange! < $1.currency!+$1.exchange!
        }
        return sortedArray
    }

}
