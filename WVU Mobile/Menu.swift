//
//  Menu.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/23/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import Foundation
import UIKit

class Menu {
    var diningHall: DiningHall
    
    var breakfast: [MenuItem] = []
    var lunch: [MenuItem] = []
    var dinner: [MenuItem] = []
    
    typealias MenuItem = String
    
    init(diningHall: DiningHall) {
        self.diningHall = diningHall
    }
    
    func getMeal(meal: Meal) -> [MenuItem] {
        switch meal {
        case .breakfast:
           return breakfast
        case .lunch:
            return lunch
        case .dinner:
            return dinner
        }
    }

    var empty: Bool {
        return breakfast.isEmpty && lunch.isEmpty && dinner.isEmpty
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

extension String {
    var removeTags: String {
        let htmlReplaceString: String  = "<[^>]+>"
        return self.replacingOccurrences(of: htmlReplaceString, with: "", options: .regularExpression)
    }
    
}
