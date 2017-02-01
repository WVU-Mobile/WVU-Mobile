//
//  OnCampusTableViewController.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 1/3/17.
//  Copyright © 2017 WVU Mobile. All rights reserved.
//

import UIKit

class OnCampusTableViewController: UITableViewController {
    var items = ["Campus Map","Dining Halls", "Help"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "campus-item", for: indexPath)

        cell.textLabel?.text = items[indexPath.row]
        
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
