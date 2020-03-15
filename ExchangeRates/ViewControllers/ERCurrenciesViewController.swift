//
//  ERCurrenciesViewController.swift
//  ExchangeRates
//
//  Created by Ignacio on 08/03/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import UIKit

class ERCurrenciesViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var currenciesArray: [String] = []
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
        
        arrayFromFileManager.getArrayForFile(ERConstants.kCurrenciesFile, type: ERConstants.kJsonType) { (value, error) in
            if value != nil {
                self.currenciesArray = value as! [String]
                self.tableView.reloadData()
            } else {
                DispatchQueue.main.async {
                    let errorStr = (error! as NSError).userInfo["error"] as! String
                    let alert = UIAlertController(title: "❗️", message: errorStr, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        self.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
}

extension ERCurrenciesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        self.currenciesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: ERConstants.kCurrencyCell) as? ERCurrencyTableViewCell
        
        let currencyCode = self.currenciesArray[indexPath.row]
        cell?.currencyLabel.text = currencyCode
        cell?.currencyDetailedLabel.text = ERCurrencyUtils.getCurrencyName(forCurrencyCode: currencyCode)
        cell?.currencyFlagImg.image = UIImage(named: currencyCode)
        
        return cell!
    }
}

extension ERCurrenciesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = tableView.cellForRow(at: indexPath)
        cell!.isUserInteractionEnabled = false
        
        if numberOfRowsSelected < ERConstants.kPairOfCurrencies {
            numberOfRowsSelected += 1
            currencyPair = currencyPair + self.currenciesArray[indexPath.row]
            if numberOfRowsSelected >= ERConstants.kPairOfCurrencies {
                let currencyDict:[String: String] = [ERConstants.kCurrencyPair: currencyPair]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: ERConstants.kCurrenciesSelectedNotification), object: nil, userInfo: currencyDict)
                dismiss(animated: true, completion: nil)
            }
            
        }
    }
}


