//
//  ERCurrencyTableViewCell.swift
//  ExchangeRates
//
//  Created by Ignacio on 08/03/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import UIKit

class ERCurrencyTableViewCell: UITableViewCell {
    
    @IBOutlet var currencyFlagImg: UIImageView!
    @IBOutlet var currencyLabel: UILabel!
    @IBOutlet var currencyDetailedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType = selected ? .checkmark : .none
    }

}
