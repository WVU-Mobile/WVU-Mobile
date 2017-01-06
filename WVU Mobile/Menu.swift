//
//  Menu.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/23/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import Foundation

class Menu {
    var diningHall: DiningHall
    var menu = [MenuItem]()
    
    init(diningHall: DiningHall) {
        self.diningHall = diningHall
    }
    
    func getMeal(meal: Meal) -> [MenuItem] {
        var mealMenu = [MenuItem]()
        
        for i in menu {
            if i.meal == meal {
                mealMenu.append(i)
            }
        }
        return mealMenu
    }
    
    enum Meal {
        case breakfast, lunch, dinner
        
        var name: String {
            switch self {
            case .breakfast:
                return "Breakfast"
            case .lunch:
                return "Lunch"
            case .dinner:
                return "Dinner"
            }
        }
    }
}
