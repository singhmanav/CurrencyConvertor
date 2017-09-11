//
//  APIBase.swift
//  Currency Convertor
//
//  Created by Manav on 11/09/17.
//  Copyright © 2017 Manav. All rights reserved.
//

import Foundation

public class APIBase {
    internal var callback : ((_ response: AnyObject?) -> Void)?
    internal var methodName : String?
    internal var isExecuting = false
    internal var showError = true
}
