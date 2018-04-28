//
//  RoundedTable.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/27/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import UIKit

class RoundedTable: UITableView {
    override func draw(_ rect: CGRect) {
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 5.0
        
        self.clipsToBounds = true
        
    }

}
