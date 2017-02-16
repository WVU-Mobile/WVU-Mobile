//
//  PRTStatus.swift
//  WVU Mobile
//
//  Created by Richard Deal on 12/17/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import Foundation
import UIKit

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
        case Normal = 1, DownBetween = 2, Down = 3, DownAll = 4, Free = 5, DownOne = 8, ClosedSunday = 6, Closed = 7, DownMultiple = 10, Unknown
        
        var overall: String {
            switch self.rawValue {
            case 1:
                return "Running"
            case 2, 5, 8, 10:
                return "Warning"
            case 4, 3:
                return "Down"
            case 6, 7:
                return "Closed"
            default:
                return "Unknown"
            }
        }
        
        var color: UIColor {
            let green        = UIColor(red: 40/255, green: 162/255, blue: 108/255, alpha: 1.0) /* #28a26c */
            let orange       = UIColor(red: 233/255, green: 166/255, blue: 87/255, alpha: 1.0) /* #e9a657 */
            let red          = UIColor(red: 234/255, green: 96/255, blue: 69/255, alpha: 1.0) /* #ea6045 */
            let pink         = UIColor(red: 255/255, green: 200/255, blue: 200/255, alpha: 1.0) //#fea094
            let homeDarkBlue = UIColor(red: 25/255,  green: 50/255,  blue: 75/255,  alpha: 0.9)

            switch self.rawValue {
            case 1:
                return green
            case 2, 5, 8, 10:
                return orange
            case 4, 3:
                return red
            case 6, 7:
                return homeDarkBlue
            default:
                return pink
            }
        }
        
        var image: UIImage {
            switch self.rawValue {
            case 1:
                return UIImage(named: "Check")!
            case 2, 5, 8, 10:
                return UIImage(named: "Yield")!
            case 4, 3:
                return UIImage(named: "Stop")!
            case 6, 7:
                return UIImage(named: "ZZZ")!
            default:
                return UIImage(named: "IDK")!
            }
        }
        
        var prtImage: UIImage {
            switch self.rawValue {
            case 1, 6, 7, 2, 5, 8, 10:
                return UIImage(named: "PRT")!
            default:
                return UIImage(named: "PRT-Borked")!
            }
        }
        
        func statusWith(time: Date) -> String {
            switch self.rawValue {
            case 1:
                return "The PRT was confirmed to be running on a normal schedule at \(time.hourPrint)."
            case 2, 5, 8, 10:
                return "The PRT was reported to partially down at \(time.hourPrint)."
            case 4, 3:
                return "The PRT was reported to be down at \(time.hourPrint)."
            case 6, 7:
                return "The PRT is closed."
            default:
                return "An unknown status was reported."
            }
        }
    }
}


