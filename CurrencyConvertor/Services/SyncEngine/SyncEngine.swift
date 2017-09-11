//
//  SyncEngine.swift
//  Currency Convertor
//
//  Created by Manav on 11/09/17.
//  Copyright © 2017 Manav. All rights reserved.
//

import Foundation
import UIKit

class SyncEngine : NSObject {
	static let sharedSyncEngine = SyncEngine()
	var hostReachability : Reachability!
		
	private override init() {
		super.init()
		//ERROR: This prevents others from using the default '()' initializer for SyncEngine class.
	} //This prevents others from using the default '()' initializer for this class.
	
	//Reachability
	@objc func reachabilityChanged(notification: NSNotification) -> Void {
		
	}
	
	
// API Models
	
	func getLatest(base: [String: AnyObject]?,callback: ((_ response: AnyObject?) -> Void)?) -> Void {
		
		let latest = Latest()
		latest.callback = { response in
			if callback != nil { callback!(response) }
		}
		latest.getLatest(base: base)
	}
    
}





