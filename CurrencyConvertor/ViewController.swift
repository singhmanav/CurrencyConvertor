//
//  ViewController.swift
//  Currency Convertor
//
//  Created by Manav on 11/09/17.
//  Copyright © 2017 Manav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let currencies = [Currency]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = currencies.count == 0 ? 2 : currencies.count + 1
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        let count = currencies.count == 0 ? 1 : currencies.count
        switch indexPath.row {
        case count :
            cell = tableView.dequeueReusableCell(withIdentifier: "addCell", for: indexPath)
        default :
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
        }
        
        return cell
    }
}

