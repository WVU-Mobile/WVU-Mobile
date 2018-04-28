//
//  MenuItem.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/18/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import Foundation

class MenuItem {
    var meal: Menu.Meal
    var name: String
    
    init(meal: String, name: String) {
        let m = meal.lowercased()
        
        if m.contains("breakfast") {
            self.meal = .breakfast
        } else if m.contains("lunch") {
            self.meal = .lunch
        } else {
            self.meal = .dinner
        }
        self.name = name
    }
    
    var string: String {
        return "meal is \(meal) \(name)"
    }
    
}
