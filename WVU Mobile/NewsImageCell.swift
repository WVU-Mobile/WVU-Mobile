//
//  NewsImageCell.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/28/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import UIKit

class NewsImageCell: UITableViewCell {

    @IBOutlet weak var source: UIImageView!
    @IBOutlet weak var sourceName: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var picture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layoutMargins = UIEdgeInsets.zero
        self.preservesSuperviewLayoutMargins = false
        
    }
    
}
