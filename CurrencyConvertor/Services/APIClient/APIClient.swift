//
//  APIClient.swift
//  Currency Convertor
//
//  Created by Manav on 11/09/17.
//  Copyright © 2017 Manav. All rights reserved.
//

import Foundation

public class APIClient {
	static func customHeaders() -> [String: String]? {
		let keychainItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: Constants.authorisation, accessGroup: KeychainConfiguration.accessGroup)
		do{
			let password = try keychainItem.readPassword()
			return  ["Authorization": password]
		}
		catch {
			return nil
		}
	}
}
