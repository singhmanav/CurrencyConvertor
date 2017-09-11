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
    
    class func parseJsonToDictionary(data: Data) -> (AnyObject?,Error?) {
        
        let _ =  NSString(data: data, encoding:String.Encoding.utf8.rawValue)
        
        // Convert server json response to NSDictionary
        do {
            let JSONObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return (JSONObject as AnyObject,nil)
        } catch let error {
            return (nil,error)
        }
        
    }
    
    class func manageServerResponseError(source: AnyObject?) -> (AnyObject?,String?) {
        var response : AnyObject?
        var str : String?
        if source != nil &&  source is [String : AnyObject] {
            let statusNumber = source!["status"] as? NSNumber
            let messageString = source!["message"] as? String
            if ((statusNumber != nil) && (messageString != nil) && statusNumber != 200) == true {
                str = messageString
                response = nil
            } else {
                response = source
                str = nil
            }
        } else{
            response = source
            str = nil
        }
        return (response,str)
    }
}
