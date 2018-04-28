//
//  BusTableViewCell.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 1/7/17.
//  Copyright © 2017 WVU Mobile. All rights reserved.
//

import UIKit

class BusTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var semester: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    static func openLabel(open: Bool) -> String {
        if open {
            return "Open"
        } else {
            return "Closed"
        }
    }
    
    static func color(open: Bool) -> UIColor {
        if open {
            return Colors.green
        } else {
            return Colors.gray
        }
    }

}
