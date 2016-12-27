//
//  PRT.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/23/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import Foundation

class PRT {    
    var status: Status
    var message: String
    var time: Date
    
    init(status: Int, message: String, time: Int) {
        if let s = Status(rawValue: status) {
            self.status = s
        } else {
            self.status = .Unknown
        }
        
        self.message = message
        self.time = Date(timeIntervalSince1970: TimeInterval(time))
    }
    
    enum Status: Int {
        case Normal = 1, DownBetween = 2, DownAll = 4, Free = 5, DownOne = 6, ClosedSunday = 8, Closed = 7, DownMultiple = 10, Unknown
        
        var overall: String {
            switch self.rawValue {
            case 1:
                return "Running"
            case 2, 5, 6, 10:
                return "Warning"
            case 4:
                return "Down"
            case 8, 7:
                return "Closed"
            default:
                return "Unknown"
            }
        }
        
        func statusWith(time: Date) -> String {
            switch self.rawValue {
            case 1:
                return "The PRT was confirmed to be running on a normal schedule at \(time.hourPrint)."
            case 2, 5, 6, 10:
                return "The PRT was reported to partially down at \(time.hourPrint)."
            case 4:
                return "The PRT was reported to be down at \(time.hourPrint)."
            case 8, 7:
                return "The PRT is closed."
            default:
                return "An unknown status was reported."
            }
        }
    }
}
