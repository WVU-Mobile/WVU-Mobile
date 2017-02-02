//
//  LiteMenuTableViewController.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 2/2/17.
//  Copyright © 2017 WVU Mobile. All rights reserved.
//

import Foundation
import UIKit

class LiteMenuTableViewController: UITableViewController {
    var menu: Menu!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if menu != nil {
            return menu.diningHall.meals.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if menu != nil {
            return menu.getMeal(meal: menu.diningHall.meals[section]).count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return menu.diningHall.meals[section].name
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "food", for: indexPath)
        
        cell.textLabel?.text = menu.getMeal(meal: menu.diningHall.meals[indexPath.section])[indexPath.row].name
        
        return cell
    }
}
