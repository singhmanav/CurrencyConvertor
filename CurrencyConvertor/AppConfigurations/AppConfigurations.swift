//
//  AppConfigurations.swift
//  Currency Convertor
//
//  Created by Manav on 07/12/16.
//  Copyright © 2016 Manav. All rights reserved.
//

import Foundation
import UIKit

let Configurations = AppConfigurations()
struct AppConfigurations {
    private var configurationType: String?
    private var configuration : [String: AnyObject]?
    
    init() {
        self.configurationType = getConfigurationType()
        self.configuration = nil
        if let plistPath = Bundle.main.path(forResource: "Configurations", ofType: ".plist") {
            if let config = NSDictionary(contentsOfFile: plistPath) {
                if self.configurationType != nil {
                    self.configuration = config.object(forKey: self.configurationType!) as? [String :
                        AnyObject]
                }
            }
        }
        manageAutolayoutLogs()
    }
    
    func getBaseURL() -> String {
        return self.configuration!["SERVICE_BASE_URL"] as! String
    }
    
    func getTimeOutInterval() -> NSNumber {
        return self.configuration!["TIME_OUT_INTERVAL"] as! NSNumber
    }
    
    func isSSLEnabled() -> Bool {
        return self.configuration!["SSL_ENABLED"] as! Bool
    }
    
    func isIgnoreAutoLayoutLogs() -> Bool {
        return self.configuration!["IGNORE_AUTOLAYOUT_LOGS"] as! Bool
    }
    
    private func getConfigurationType() -> String {
        if isDebug() == true {
            return "Development"
        } else {
            return "Production"
        }
    }
    
    private func isDebug() -> Bool {
        var status: Bool
        #if DEBUG
            status = true
        #else
            status = false
        #endif
        return status
    }
    
    private func manageAutolayoutLogs() -> Void {
        UserDefaults.standard.set(!isIgnoreAutoLayoutLogs(), forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        UserDefaults.standard.synchronize()
    }
}

