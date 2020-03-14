//
//  ERExchangeListViewController.swift
//  ExchangeRates
//
//  Created by Ignacio on 10/03/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import UIKit

class ERExchangeListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var timer = Timer()
    let currencyExchangeManager = ERCurrencyExchangeManager()
    var exchangeArray: [ERExchangeModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateArrayOfExchanges), name:NSNotification.Name(rawValue: ERConstants.kCurrenciesSelectedNotification), object: nil)
        
        requestExchangeRatesWithInterval()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        NotificationCenter.default.removeObserver(self)
        timer.invalidate()
    }
    
    @objc func updateArrayOfExchanges(_ notification: NSNotification)
    {
        if let pair = notification.userInfo?[ERConstants.kCurrencyPair] as? String {
            var currencyPairArray = UserDefaults.standard.array(forKey: ERConstants.kCurrenciesPairs) ?? []
            currencyPairArray.append(pair)
            UserDefaults.standard.set(currencyPairArray, forKey: ERConstants.kCurrenciesPairs)
        }
    }
    
    func requestExchangeRatesWithInterval()
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.requestExchangeRates), userInfo: nil, repeats: true)
    }
    
    @objc func requestExchangeRates()
    {
        currencyExchangeManager.getCurrencyExchange(ERServiceUtils.getPairsUrl()) { (value, error) in
            self.exchangeArray = value!
            
            self.exchangeArray.sort {
                $0.currency! < $1.currency!
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func setAttributeTextForString(value: String) -> NSMutableAttributedString {
        let exchangeValueText = NSMutableAttributedString.init(string: value)
        
        exchangeValueText.setAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)], range: NSMakeRange(value.length-2, 2))

        return exchangeValueText
    }
    
}

extension ERExchangeListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        self.exchangeArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        83
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: ERConstants.kExchangeCell) as? ERExchangeTableViewCell
        
        let exchange = self.exchangeArray[indexPath.row]
        cell?.currencyLabel.text = exchange.currency
        cell?.currencyDescriptionLabel.text = exchange.currencyDetail
        cell?.exchangeValueLabel.attributedText = setAttributeTextForString(value: String(format:"%.4f", exchange.exchangeValue!))
        cell?.exchangeValueDescriptionLabel.text = exchange.exchangeCurrencyDetail
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        timer.invalidate()
    }
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        requestExchangeRatesWithInterval()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let exchange = self.exchangeArray[indexPath.row]
            let exchangePair = exchange.currency! + exchange.exchange!
            var currencyPairArray: [String] = []
            
            self.exchangeArray.remove(at: indexPath.row)
            
            currencyPairArray = UserDefaults.standard.array(forKey: ERConstants.kCurrenciesPairs) as! [String]
            if let index = currencyPairArray.firstIndex(of: exchangePair) {
                currencyPairArray.remove(at: index)
            }
            
            UserDefaults.standard.set(currencyPairArray, forKey: ERConstants.kCurrenciesPairs)
            if currencyPairArray.count == 0 {
                navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}

extension ERExchangeListViewController: UITableViewDelegate {
    
}
