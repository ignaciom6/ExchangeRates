//
//  ERCurrenciesViewController.swift
//  ExchangeRates
//
//  Created by Ignacio on 08/03/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import UIKit

class ERCurrenciesViewController: UIViewController {
    
    let kCurrenciesFile = "currencies"
    let kJsonType = "json"
    let kCurrenciesSelectedNotification = "CurrenciesSelected"
    let kPairOfCurrencies = 2

    @IBOutlet var tableView: UITableView!
    var currenciesArray: [String]?
    var numberOfRowsSelected = 0
    var currencyPair = ""
    let arrayFromFileManager = ERArrayFromFileManager()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        
        arrayFromFileManager.getArrayForFile(kCurrenciesFile, type: kJsonType) { (value, error) in
            if value != nil {
                self.currenciesArray = value as? [String]
                self.tableView.reloadData()
            } else {
                self.dismiss(animated: true, completion: nil)
                print(error as Any)
            }
            
        }
    }
    
}

extension ERCurrenciesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        self.currenciesArray!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell") as? ERCurrencyTableViewCell
        
        let currencyCode = self.currenciesArray![indexPath.row]
        cell?.currencyLabel.text = currencyCode
        cell?.currencyDetailedLabel.text = ERCurrencyUtils.getCurrencyName(forCurrencyCode: currencyCode)
        
        return cell!
    }
}

extension ERCurrenciesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.isUserInteractionEnabled = false
        
        if numberOfRowsSelected < kPairOfCurrencies {
            numberOfRowsSelected += 1
            currencyPair = currencyPair + self.currenciesArray![indexPath.row]
            if numberOfRowsSelected >= kPairOfCurrencies {
                if let presenter = presentingViewController as? ERInitialViewController {
                    presenter.currencyPair = currencyPair
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kCurrenciesSelectedNotification), object: nil)
                dismiss(animated: true, completion: nil)
            }
        }
    }
}


