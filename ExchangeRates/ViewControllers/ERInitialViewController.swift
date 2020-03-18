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
    var currencyPairArray: [String] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        currencyPairArray = ERUserDefaultsUtils.getStoredArray()
        
        if currencyPairArray.count > 0 {
            performSegue(withIdentifier: ERConstants.kInitialViewToExchangeListSegue, sender: nil)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
    }
    
}
