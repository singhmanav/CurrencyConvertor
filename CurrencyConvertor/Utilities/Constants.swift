//
//  Constants.swift
//  Currency Convertor
//
//  Created by Manav on 11/09/17.
//  Copyright © 2017 Manav. All rights reserved.
//

import Foundation

public enum HttpMethodType: Int {
	case GET = 1
	case POST = 2
	case PUT = 3
	
	func typeString() -> String {
		switch self {
		case .GET:
			return "GET"
		case .POST:
			return "POST"
		case .PUT:
			return "PUT"
		}
	}
}

public class Constants {
	static var isOnline :Bool {
		return Utils.hasConnectivity()
	}
	static let authorisation = "Authorization"
}
