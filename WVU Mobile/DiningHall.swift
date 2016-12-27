//
//  DiningHall.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/18/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import Foundation

enum DiningHall: Int {
    case CafeEvansdale = 1, Summit = 2, Arnold = 3, Boreman = 4, TerraceRoom = 5, Hatfields = 6
    
    var campus: String {
        switch self {
        case .CafeEvansdale:
            return "Evansdale"
        default:
            return "Downtown"
        }
    }
    
    func url(on date: Date) -> String {
        let components = NSCalendar.current.dateComponents([.day, .month, .year], from: date)
        
        return "https://diningmenuservice.wvu.edu/\(self.rawValue)/\(components.month!)/\(10)/\(components.year!)/1410376600000/?callback="
    }
    
    var name: String {
        switch self {
        case .CafeEvansdale:
            return "Cafe Evansdale"
        case .Summit:
            return "Summit"
        case .Arnold:
            return "Arnold"
        case .Boreman:
            return "Boreman"
        case .TerraceRoom:
            return "Terrace Room"
        case .Hatfields:
            return "Hatfields"
        }
    }
    
    // hours of operation -- hard coded bc there is no API
    
    // location -- coordinates
}
