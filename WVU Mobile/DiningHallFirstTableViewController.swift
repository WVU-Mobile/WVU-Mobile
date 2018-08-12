//
//  DiningHallFirstTableViewController.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 1/3/17.
//  Copyright © 2017 WVU Mobile. All rights reserved.
//

import UIKit

class DiningHallFirstTableViewController: UITableViewController {
    var items: [DiningHall] = [.boreman, .evansdale, .hatfields, .summit, .terrace]

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DiningHallSelectionCell

        cell.diningHallName.text = items[indexPath.row].name
        cell.diningHallCampus.text = items[indexPath.row].campus
        
        cell.open.text = DiningHallSelectionCell.openLabel(open: items[indexPath.row].isOpen)
        cell.open.textColor = DiningHallSelectionCell.color(open: items[indexPath.row].isOpen)

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiningContainer") as? DiningHallContainerViewController else { return }
        
        viewController.diningHall = items[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
