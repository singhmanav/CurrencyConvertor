//
//  Utils.swift
//  Currency Convertor
//
//  Created by Manav on 11/01/17.
//  Copyright © 2017 Manav. All rights reserved.
//

import UIKit

class Utils: NSObject {

	class func isValidEmail(testStr:String) -> Bool {
		let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
		let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
		return emailTest.evaluate(with: testStr)
	}
	
	class func hasConnectivity() -> Bool {
		let networkStatus: Bool!
		let reachability: Reachability =  Reachability.init(hostname: Configurations.getBaseURL())!
		networkStatus = (reachability.currentReachabilityStatus == .notReachable) ? false : true
		return networkStatus
	}
	
    
	class func clearKeychain() {
		
	}
	class func saveAuthorization(key :String) -> Void {
		
	}
}
