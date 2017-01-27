//
//  CalendarDayCollectionViewCell.swift
//  DateView
//
//  Created by Kaitlyn Landmesser on 1/10/17.
//  Copyright © 2017 Industrial Scientific. All rights reserved.
//

import UIKit

class CalendarDayCollectionViewCell: UICollectionViewCell {
    var day: UILabel!

    override init(frame: CGRect) {
        day = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        day.font = UIFont(name: "Avenir-Light", size: 15)
        day.textAlignment = .center
        
        super.init(frame: frame)
        
        self.addSubview(day)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
