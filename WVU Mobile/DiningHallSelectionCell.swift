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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
