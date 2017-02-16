//
//  Date.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/18/16.
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
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func nextDay() -> Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
    func previousDay() -> Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    
    func nextMonth() -> Date {
        return Calendar.current.date(byAdding: .month, value: 1, to: self)!
    }
    
    func previousMonth() -> Date {
        return Calendar.current.date(byAdding: .month, value: -1, to: self)!
    }
    
    func sameDay(date: Date) -> Bool {
        return Calendar.current.isDate(date, inSameDayAs: self)
    }
    
    func sameMonth(date: Date) -> Bool {
        return Calendar.current.compare(date, to: self, toGranularity: .month) == .orderedSame
    }
    
    var headerFormat: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        
        return formatter.string(from: self)
    }
    
    var d: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        
        return formatter.string(from: self)
    }
    
    var full: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        
        return formatter.string(from: self)
    }
    
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
}
