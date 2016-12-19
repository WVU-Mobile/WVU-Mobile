//
//  Menu.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/18/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import Foundation


class Menu {
    let diningHall: DiningHall
    var todaysMenu: [MenuItem]
    
    init(diningHall: DiningHall) {
        self.diningHall = diningHall
        todaysMenu = []
    }
    
    func getMenu(on date: Date, completion: ([MenuItem]?) -> Void) {
        
    }
    
}
