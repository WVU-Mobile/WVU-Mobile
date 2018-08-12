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
            if let favoriteDiningHallString = UserDefaults.standard.string(forKey: "favoriteDiningHall"), let favoriteDiningHall = DiningHall(rawValue: favoriteDiningHallString) {
                return favoriteDiningHall
            }
            return DiningHall.boreman
        }
        set(value) {
            UserDefaults.standard.set(value.rawValue, forKey: "favoriteDiningHall")
        }
    }
}
