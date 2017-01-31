//
//  BusesTableViewController.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 1/7/17.
//  Copyright © 2017 WVU Mobile. All rights reserved.
//

import UIKit
import MapKit

class BusesTableViewController: UITableViewController {
    var routes: [BusRoute]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        routes = [.campusPM, .downtownPM, .green, .orange, .gold, .red, .tyrone, .purple, .cassville, .blue, .crown, .mountainHeights, .graftonRoad, .pink, .grey, .westRun, .westRunLate, .blueAndGold, .valleyView]
        
        routes.sort(by: { $0.isOpen && !$1.isOpen })
        
        self.title = "Buses"
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routes.count
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: BusTableViewCell

        if let _ = self.routes[indexPath.row].semester {
            cell = tableView.dequeueReusableCell(withIdentifier: "subtext", for: indexPath) as! BusTableViewCell
            cell.semester.text = self.routes[indexPath.row].semester
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "bus", for: indexPath) as! BusTableViewCell
        }
        cell.name.text = self.routes[indexPath.row].name
        
        if routes[indexPath.row].isOpen {
            cell.icon.image = UIImage(named: "Bus")
        } else {
            cell.icon.image = UIImage(named: "Bus-Closed")
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let c = cell as! BusTableViewCell
        if routes[indexPath.row].isOpen {
            c.icon.image = UIImage(named: "Bus")
        } else {
            c.icon.image = UIImage(named: "Bus-Closed")
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Bus services are provided by Mountain Line Transit Authority. Operating hours and routes are subject to change without notice. For the most up to date information, visit busride.org or call (304)291-7433."
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = LineViewController()
        vc.line = routes[indexPath.row]
        vc.coords = BusRoute.coords
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
