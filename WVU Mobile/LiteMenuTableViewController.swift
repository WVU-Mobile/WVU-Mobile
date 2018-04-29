//
//  LiteMenuTableViewController.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 2/2/17.
//  Copyright © 2017 WVU Mobile. All rights reserved.
//

import UIKit

class LiteMenuTableViewController: UITableViewController {
    var menu: Menu?
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if let m = menu {
            return m.diningHall.meals.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let m = menu {
            return m.getMeal(meal: m.diningHall.meals[section]).count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return menu?.diningHall.meals[section].name
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "food", for: indexPath)
        
        if let meal = menu?.diningHall.meals[indexPath.section] {
            cell.textLabel?.text = menu?.getMeal(meal: meal)[indexPath.row].name
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 25))
        view.backgroundColor = UIColor.white
        
        let border = CALayer()
        border.frame = CGRect.init(x: 0, y: view.frame.height, width: view.frame.width, height: 0.5)
        border.backgroundColor = Colors.lightGray.cgColor;
        view.layer.addSublayer(border)

        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 25))
        label.text = menu?.diningHall.meals[section].name
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.black
        label.textAlignment = .center
        
        view.addSubview(label)
        
        return view
    }
    
}
