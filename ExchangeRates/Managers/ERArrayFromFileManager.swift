//
//  ERArrayFromFileManager.swift
//  ExchangeRates
//
//  Created by Ignacio on 08/03/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import UIKit

class ERArrayFromFileManager: NSObject {

    func getArrayForFile(_ file: String?, type: String?, withCompletion completion: @escaping (_ value: [AnyHashable]?, _ error: Error?) -> Void) {
        let localFileService = ERLocalFileService()
        localFileService.getDataFromFile(file, type: type, withCompletion: { value, error in
            if value != nil {
                completion(value, nil)
            } else {
                completion(nil, error!)
            }
        })
    }
    
}
