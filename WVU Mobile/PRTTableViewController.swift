//
//  PRTTableViewController.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 2/11/17.
//  Copyright © 2017 WVU Mobile. All rights reserved.
//

import UIKit

class PRTTableViewController: UITableViewController {
    var prt: PRT?
    var dimensions: [CGFloat] = [ 0.34, 0.09, 0.40, 0.11, 0.06]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        pullStatus()
    }
    
    func pullStatus() {
        DispatchQueue.global().async {
            PRTRequest.getPRTStatus(completion: { result in
                DispatchQueue.main.sync {
                    if let prt = result {
                        self.prt = prt
                        self.tableView.reloadData()
                    }
                }
            })
        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = prt {
            return dimensions.count
        } else {
            return 0
        }

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let navHeight = navigationController?.navigationBar.bounds.height {
            return CGFloat(Int(dimensions[indexPath.row] * (view.frame.height - navHeight)))

        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .none
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.minimumScaleFactor = 0.5
        
        switch indexPath.row {
        case 0:
            cell.backgroundColor = prt?.status.color
            
            let imageView = UIImageView(frame: CGRect(x: view.bounds.width/2 - (((view.bounds.height - 64) * 0.31)/2) , y: ((view.bounds.height - 64) * 0.02) , width: (view.bounds.height - 64) * 0.31, height: (view.bounds.height - 64) * 0.31))
            
            imageView.image = prt?.status.image
            cell.addSubview(imageView)
        case 1:
            cell.textLabel?.text = prt?.status.overall
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-CondensedBold", size: 30)
            cell.backgroundColor = Colors.almostWhite
            cell.textLabel?.textColor  = prt?.status.color
        case 2:
            cell.textLabel?.text = prt?.message
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 17)
        case 3:
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 13)
            cell.textLabel?.text = "Monday to Friday 6:30 AM to 10:15 PM\nSaturday 9:30 AM to 5:00 PM\nSunday CLOSED"
        case 4:
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 11)
            cell.textLabel?.text = "Always check transportation.wvu.edu for the latest hours."
            cell.selectionStyle = .default
        default:
            break
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
        if indexPath.row == 4 {
            UIApplication.shared.openURL(URL(string: "http://transportation.wvu.edu/prt/schedule")!)
        }
    }
    
}
