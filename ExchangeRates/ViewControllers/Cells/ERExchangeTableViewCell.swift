//
//  ERExchangeTableViewCell.swift
//  ExchangeRates
//
//  Created by Ignacio on 10/03/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import UIKit

class ERExchangeTableViewCell: UITableViewCell {

    @IBOutlet var currencyLabel: UILabel!
    @IBOutlet var currencyDescriptionLabel: UILabel!
    @IBOutlet var exchangeValueLabel: UILabel!
    @IBOutlet var exchangeValueDescriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
