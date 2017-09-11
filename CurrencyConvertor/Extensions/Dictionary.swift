//
//  Dictionary.swift
//  Currency Convertor
//
//  Created by Manav on 11/09/17.
//  Copyright © 2017 Manav. All rights reserved.
//

import Foundation

extension Dictionary {
    func jsonStringFromHttpParameters() -> String {
        let parameterArray = self.map { tupleArgument -> String in
            let percentEscapedKey = (tupleArgument.key as! String)
            let percentEscapedValue = (tupleArgument.value as AnyObject)
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        return parameterArray.joined(separator: "&")
    }
}
