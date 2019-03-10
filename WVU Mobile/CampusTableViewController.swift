//
//  CampusTableViewController.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 1/3/17.
//  Copyright © 2017 WVU Mobile. All rights reserved.
//

import UIKit

class CampusTableViewController: UITableViewController {
    var items = ["Map","Dining Halls", "Help"]

    fileprivate static let storyboardID = "Campus"

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "campus-item", for: indexPath) as! CampusTableViewCell
        let icon = ["Mountain","Sub","Heart"]
        cell.title.text = items[indexPath.row]
        cell.icon.image = UIImage(named: icon[indexPath.row])

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let view = MapViewController()
            self.navigationController?.pushViewController(view, animated: true)
        } else if indexPath.row == 1 {
            let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiningHallFirst")
            self.navigationController?.pushViewController(view, animated: true)
        } else if indexPath.row == 2 {
            let view = HelpViewController()
            self.navigationController?.pushViewController(view, animated: true)
        }
    }
    
}

extension CampusTableViewController {
    
    class var viewController: CampusTableViewController {
        guard let viewController = UIStoryboard(name: CampusTableViewController.storyboardID, bundle: nil).instantiateViewController(withIdentifier: CampusTableViewController.storyboardID) as? CampusTableViewController else {
            fatalError("View Controller with identifier '\(CampusTableViewController.storyboardID)' was not found.")
        }
        
        return viewController
    }
    
}
