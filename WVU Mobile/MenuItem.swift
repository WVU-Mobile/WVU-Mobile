//
//  MenuItem.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/18/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import Foundation

class MenuItem {
    var meal: Meal
    var name: String
    
    init(meal: Meal, name: String) {
        self.meal = meal
        self.name = name
    }
    
    enum Meal {
        case breakfast, lunch, dinner
    }
}
