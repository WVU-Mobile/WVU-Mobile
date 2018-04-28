//
//  DiningHallSelectionCell.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 1/6/17.
//  Copyright © 2017 WVU Mobile. All rights reserved.
//

import UIKit

class DiningHallSelectionCell: UITableViewCell {
    @IBOutlet weak var diningHallName: UILabel!
    @IBOutlet weak var diningHallCampus: UILabel!
    @IBOutlet weak var open: UILabel!

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
            return Colors.red
        }
    }
    
}
