//
//  Date.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/22/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import Foundation

extension Date {
    var prettyPrint: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy 'at' hh:mm a"
        return dateFormatter.string(from: self)
    }
    
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        return dateFormatter.string(from: self)
    }
    
    var hourPrint: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: self)
    }

    var rssDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, dd MMM yyyy HH:mm:ss zzz"
        return dateFormatter.string(from: self)
    }
    
    var timeAgo: String {
        let secondsAgo = Int(self.timeIntervalSince(Date()) * -1) // TimeInterval is in seconds 60
        let minutesAgo = Int(secondsAgo / 60)
        let hoursAgo = Int(minutesAgo / 60)
        let daysAgo = Int(hoursAgo / 24)
        
        if secondsAgo < 60 {
            return "just now"
        } else if minutesAgo < 2 {
            return "1 minute ago"
        } else if minutesAgo < 60 {
            return "\(minutesAgo) minutes ago"
        } else if hoursAgo < 2 {
            return "1 hour ago"
        } else if hoursAgo < 24 {
            return "\(hoursAgo) hours ago"
        } else if daysAgo < 2 {
            return "yesterday"
        } else {
            return "\(daysAgo) days ago"
        }
    }
    
    static func rssDate(date: String) -> Date {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, dd MMM yyyy HH:mm:ss zzz"
        if let d = dateFormatter.date(from: date) {
            return d
        }
        
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, dd MMM yyyy HH:mm:ss Z"

        if let d = dateFormatter.date(from: date) {
            return d
        } else {
            return Date()
        }
    }
}
