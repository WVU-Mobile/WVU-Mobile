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
    
    // hours of operation -- hard coded bc there is no API
    
    // location -- coordinates
}
