//
//  LoginAPI.swift
//  Currency Convertor
//
//  Created by Manav on 11/09/17.
//  Copyright © 2017 Manav. All rights reserved.
//

import Foundation

class Latest: APIBase {
	
	func getLatest(base: [String: AnyObject]?) -> Void {
		self.methodName = "/latest"
		isExecuting = true
		let urlPath = Configurations.getBaseURL() + methodName!
		let request = APIRequest(methodType: .GET, URLString: urlPath, Parameters: base)
		request.execute { (response, error) in
			self.isExecuting = false
            DispatchQueue.main.async {
                self.callback?(response)
            }
				
		}
	}
	
}
