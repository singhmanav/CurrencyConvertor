//
//  APIRequest.swift
//  Currency Convertor
//
//  Created by Manav on 11/09/17.
//  Copyright © 2017 Manav. All rights reserved.
//

import Foundation

class APIRequest: NSObject {
	private var parameters: [String:AnyObject]?
	private var method: String?
	private var urlString: String?
	private var type: HttpMethodType?
	var showErrorAlert = true
	var headers: [String:String] = [:]
	var session: URLSession!
	private var callback : ((_ response: AnyObject?, _ error: Error?) -> Void)?
    
	
	convenience internal init(methodType: HttpMethodType, URLString urlString: String, Parameters parameters: [String:AnyObject]?) {
		self.init()
		self.type = methodType
		self.method = methodType.typeString()
		self.urlString = urlString
		self.parameters = parameters
		self.callback = nil
		let configuration = URLSessionConfiguration.default
		
		let status = verifySSLHostName()
		if status == true {
			self.session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
		} else {
			self.session = URLSession(configuration: configuration, delegate: nil, delegateQueue:OperationQueue.main)
		}
		if let header = APIClient.customHeaders()  {
			addHeaders(aHeaders: header)
		}
	}
	
	func execute(completion:@escaping (_ response: AnyObject?, _ error: Error?) -> Void) {
		self.callback = completion
		if self.type != .GET {
			do {
				let data = try JSONSerialization.data(withJSONObject: self.parameters!, options: .prettyPrinted)
				let body = String(data: data, encoding: String.Encoding.utf8)
				processRequest(param: body)
			} catch {
				
			}
		} else {
			processRequest(param: self.parameters?.jsonStringFromHttpParameters())
		}
	}
	
	//Private Function
	private func addHeaders(aHeaders:[String:String]) {
		for (header, value) in aHeaders {
			headers[header] = value
		}
	}
	
	private func processRequest(param:String?) {
		// Create NSURL object
		let requestURL : NSURL!
		var myUrlString = self.urlString
		let httpMethod = self.type
		
		if httpMethod == .GET {
			if param != nil {
				myUrlString = myUrlString! + "?" + param!
			}
			requestURL = NSURL(string:myUrlString!)
		} else {
			requestURL = NSURL(string:myUrlString!)
		}
		
		// Create URL Request
		let request = NSMutableURLRequest(url:requestURL! as URL);
		// Set request HTTP method to GET or PUT
		request.httpMethod = httpMethod!.typeString()
        request.timeoutInterval = Double.init(exactly: Configurations.getTimeOutInterval())!
		if self.headers.count > 0 {
			for (key, value) in self.headers {
				request.setValue(value, forHTTPHeaderField: key)
			}
		}
		
		if param != nil && httpMethod != .GET {
			let data = param!.data(using: String.Encoding.utf8)
			request.httpBody = data
			request.addValue("application/json",forHTTPHeaderField: "Content-Type")
		}
		
		// Excute HTTP Request
		sendRequest(request: request as URLRequest)
	}
	
	
	private func sendRequest(request: URLRequest) {
		let task = self.session.dataTask(with: request, completionHandler: { (data, response, error) in
			self.manageResponse(data: data , error: error )
		})
		task.resume()
	}
	
	private func manageResponse(data: Data?, error: Error?) {
		if data == nil {
			print("ERROR: \(error!) \(error!.localizedDescription)")
			if let cb = self.callback {
				cb(nil, error!)
			}
		} else {
            let parsedObject : (AnyObject?,Error?) = Utils.parseJsonToDictionary(data: data!)
            let parseObject = parsedObject.0
            let parseError = parsedObject.1
            var response : (AnyObject?, String?)
            response = Utils.manageServerResponseError(source: parseObject)
            callback?(response.0, parseError)
            if response.1 != nil  && self.showErrorAlert == true{
                fatalError()
            }
		}
	}
    
    private func verifySSLHostName() -> Bool {
		return Configurations.isSSLEnabled()
	}
}


extension APIRequest : URLSessionDelegate {
	func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
		let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
		challenge.sender!.use(credential, for: challenge)
		completionHandler(.useCredential,credential)
	}
}


