//
//  LargeEventsCell.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/29/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import UIKit

class LargeEventsCell: UITableViewCell {
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var star: UIButton!
    @IBOutlet weak var title: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.star.imageView?.tintColor = Colors.lightBlue
        self.star.tintColor = Colors.lightBlue
        
        self.layoutMargins = UIEdgeInsets.zero
        self.preservesSuperviewLayoutMargins = false
    }
    
}
