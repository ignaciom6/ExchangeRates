//
//  ERSpinner.swift
//  ExchangeRates
//
//  Created by Ignacio on 14/03/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import UIKit

var aView: UIView?

extension UIViewController {
    func showSpinner() {
        aView = UIView(frame: self.view.bounds)
        
        var activityIndicator: UIActivityIndicatorView!
        
        switch traitCollection.userInterfaceStyle {
        case .light:
            activityIndicator = UIActivityIndicatorView(style: .gray)
        case .dark:
            activityIndicator = UIActivityIndicatorView(style: .white)
        case .unspecified: break
        @unknown default:
            break
        }

        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        aView?.addSubview(activityIndicator)
        self.view.addSubview(aView!)
    }
    
    func hideSpinner() {
        aView?.removeFromSuperview()
    }
}
