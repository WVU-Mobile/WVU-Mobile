//
//  Global.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 2/14/17.
//  Copyright © 2017 WVU Mobile. All rights reserved.
//

import Foundation

class Global {
    static var favoriteDiningHall:DiningHall {
        get {
            if let f = DiningHall(rawValue: UserDefaults.standard.integer(forKey: "favDiningHall")) {
                return f
            }
            return DiningHall.Boreman
        }
        
        set(value) {
            UserDefaults.standard.set(value.rawValue, forKey: "favDiningHall")
        }
    }
}
