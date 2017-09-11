//
//  Navigation.swift
//  Currency Convertor
//
//  Created by Manav on 13/12/16.
//  Copyright © 2016 Manav. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    func setCustomNavigationBar(imageName : String) -> Void {
        let navigationBarImageName = imageName
        let navigationBarBackground = UIImage(named: navigationBarImageName)?.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 10, 0, 10))
        self.navigationBar.setBackgroundImage(navigationBarBackground, for: .default)
        self.navigationBar.setBackgroundImage(navigationBarBackground, for: .compact)
        self.navigationBar.tintColor = UIColor.white
    }
}
