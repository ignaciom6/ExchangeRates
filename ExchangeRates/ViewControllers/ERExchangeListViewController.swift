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
        tableView.allowsSelection = false
        
        requestExchangeRatesWithInterval()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.showSpinner()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateArrayOfExchanges), name:NSNotification.Name(rawValue: ERConstants.kCurrenciesSelectedNotification), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        NotificationCenter.default.removeObserver(self)
        timer.invalidate()
    }
    
    @objc func updateArrayOfExchanges(_ notification: NSNotification)
    {
        DispatchQueue.main.async {
            self.showSpinner()
        }
        
        if let pair = notification.userInfo?[ERConstants.kCurrencyPair] as? String {
            ERCurrencyUtils.updateCurrencies(pair: pair)
        }
    }
    
    func requestExchangeRatesWithInterval()
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.requestExchangeRates), userInfo: nil, repeats: true)
    }
    
    @objc func requestExchangeRates()
    {
        currencyExchangeManager.getCurrencyExchange(ERServiceUtils.getPairsUrl()) { (value, error) in
            if value != nil {
                self.exchangeArray = ERCurrencyUtils.sortExchangeModelArray(array: value!)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                self.timer.invalidate()
                
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "❗️", message: error?.localizedDescription ?? "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in
                        self.showSpinner()
                        self.requestExchangeRatesWithInterval()
                    }))
                    self.present(alert, animated: true)
                }
            }
            DispatchQueue.main.async {
                self.hideSpinner()
            }
        }
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
        cell?.exchangeValueLabel.attributedText = ERCurrencyUtils.setAttributeTextForString(value: String(format:"%.4f", exchange.exchangeValue!))
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
            var currencyPairArray: [String] = []

            let exchange = self.exchangeArray[indexPath.row]
            let exchangePair = exchange.currency! + exchange.exchange!
            
            self.exchangeArray.remove(at: indexPath.row)
            
            currencyPairArray = ERUserDefaultsUtils.getStoredArray()
            if let index = currencyPairArray.firstIndex(of: exchangePair) {
                currencyPairArray.remove(at: index)
            }
            
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
            ERUserDefaultsUtils.storeArray(currencyArray: currencyPairArray)
            if currencyPairArray.count == 0 {
                navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}

extension ERExchangeListViewController: UITableViewDelegate {
    
}
