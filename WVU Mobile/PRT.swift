//
//  PRT.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/23/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import UIKit

class PRT {    
    var status: Status
    var message: String
    var time: Date
    
    init(status: Int, message: String, time: Int) {
        self.status = Status(rawValue: status) ?? .unknown
        
        self.message = message
        self.time = Date(timeIntervalSince1970: TimeInterval(time))
    }
    
    enum Status: Int {
        case normal = 1
        case downBetween = 2
        case down = 3
        case downAll = 4
        case free = 5
        case downOne = 8
        case closedSunday = 6
        case closed = 7
        case downMultiple = 10
        case unknown
        
        var overall: String {
            switch self {
            case .normal:
                return "Running"
            case .downBetween, .free, .downOne, .downMultiple:
                return "Warning"
            case .downAll, .down:
                return "Down"
            case .closedSunday, .closed:
                return "Closed"
            case .unknown:
                return "Unknown"
            }
        }
        
        var color: UIColor {
            switch self {
            case .normal:
                return Colors.green
            case .downBetween, .free, .downOne, .downMultiple:
                return Colors.orange
            case .downAll, .down:
                return Colors.red
            case .closedSunday, .closed:
                return Colors.homeDarkBlue
            case .unknown:
                return Colors.pink
            }
        }
        
        var image: UIImage {
            switch self {
            case .normal:
                return #imageLiteral(resourceName: "Check")
            case .downBetween, .free, .downOne, .downMultiple:
                return #imageLiteral(resourceName: "Yield")
            case .downAll, .down:
                return #imageLiteral(resourceName: "Stop")
            case .closedSunday, .closed:
                return #imageLiteral(resourceName: "ZZZ")
            case .unknown:
                return #imageLiteral(resourceName: "IDK")
            }
        }
        
        var prtImage: UIImage {
            switch self {
            case .normal, .free, .unknown:
                return #imageLiteral(resourceName: "PRT")
            case .closedSunday, .closed:
                return #imageLiteral(resourceName: "PRT-Dark")
            case .downAll, .down, .downBetween, .downOne, .downMultiple:
                return #imageLiteral(resourceName: "PRT-Borked")
            }
        }
        
        func statusWith(time: Date) -> String {
            switch self {
            case .normal:
                return "The PRT was confirmed to be running on a normal schedule at \(time.hourPrint)."
            case .downBetween, .free, .downOne, .downMultiple:
                return "The PRT was reported to partially down at \(time.hourPrint)."
            case .downAll, .down:
                return "The PRT was reported to be down at \(time.hourPrint)."
            case .closedSunday, .closed:
                return "The PRT is closed."
            case .unknown:
                return "An unknown status was reported."
            }
        }
    }
    
}
