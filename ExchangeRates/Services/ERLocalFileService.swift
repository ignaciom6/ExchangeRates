//
//  ERLocalFileService.swift
//  ExchangeRates
//
//  Created by Ignacio on 08/03/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import UIKit

class ERLocalFileService: NSObject {
    
    let kLocalFileServiceDomain = "ERLocalFileService"
    let kRetrieveFileError = "Could not retrieve file"
    
    func getDataFromFile(_ file: String?, type format: String?, withCompletion completion: @escaping (_ value: [AnyHashable]?, _ error: Error?) -> Void) {
        let path = Bundle.main.path(forResource: file, ofType: format)
        let data = NSData(contentsOfFile: path ?? "") as Data?

        if data != nil {
            var currenciesArray: [String]?
            var err: NSError? = nil
            do {
                if let data = data {
                    currenciesArray = try JSONSerialization.jsonObject(with: data, options: []) as? [String]
                }
            } catch {
                err = NSError(domain: kLocalFileServiceDomain, code: -1, userInfo: [ERConstants.kErrorString: kRetrieveFileError])
            }
            completion(currenciesArray, err)
        } else {
            let error = NSError(domain: kLocalFileServiceDomain, code: -1, userInfo: [
                ERConstants.kErrorString: kRetrieveFileError
            ])
            completion(nil, error)
        }
    }

}
