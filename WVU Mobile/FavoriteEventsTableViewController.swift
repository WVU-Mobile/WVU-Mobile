//
//  FavoriteEventsTableViewController.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 1/2/17.
//  Copyright © 2017 WVU Mobile. All rights reserved.
//

import UIKit

class FavoriteEventsTableViewController: UITableViewController {
    var favoriteEvents: [String] {
        get {
            if let f = UserDefaults.standard.array(forKey: "favorite-events") {
                return f as! [String]
            }
            return []
        }
        
        set(value) {
            UserDefaults.standard.set(value, forKey: "favorite-events")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteEvents.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "event", for: indexPath) as! LargeEventsCell
        
        let favs = favoriteEvents[indexPath.row].components(separatedBy: "%%&")
        
        cell.details.text = favs.last
            
        cell.time.text = Date.rssDate(date: favs.first!).prettyPrint.replacingOccurrences(of: "at 12:00 AM", with: "- All Day")
        
        let image = UIImage(named: "Star-Filled")!
        let tinted = image.withRenderingMode(.alwaysTemplate)
            
        cell.star.setImage(tinted, for: .normal)
        
        cell.star.tag = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    @IBAction func didSelectStar(_ sender: UIButton) {

            favoriteEvents.remove(at: sender.tag)
        
            self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }


}
