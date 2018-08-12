//
//  FavoriteDiningHallTableViewController.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 2/14/17.
//  Copyright © 2017 WVU Mobile. All rights reserved.
//

import UIKit

class FavoriteDiningHallTableViewController: UITableViewController {
    let diningHalls: [DiningHall] = [.boreman, .evansdale, .hatfields, .summit, .terrace]

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diningHalls.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteDiningHall", for: indexPath)

        cell.textLabel?.text = diningHalls[indexPath.row].name
        
        if diningHalls[indexPath.row] == Global.favoriteDiningHall {
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Global.favoriteDiningHall = diningHalls[indexPath.row]
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
}
