//
//  ERUserDefaultsUtils.swift
//  ExchangeRates
//
//  Created by Ignacio on 18/03/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import UIKit

class ERUserDefaultsUtils: NSObject {
    
    class func storeArray(currencyArray:[String]) {
        UserDefaults.standard.set(currencyArray, forKey: ERConstants.kCurrenciesPairs)
    }
    
    class func getStoredArray() -> [String] {
        return UserDefaults.standard.array(forKey: ERConstants.kCurrenciesPairs) as! [String]
    }
}
