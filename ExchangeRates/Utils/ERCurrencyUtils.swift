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

}
