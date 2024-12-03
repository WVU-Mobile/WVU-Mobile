//
//  Date+Extension.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/2/24.
//

import Foundation

extension Date {
    var rssDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, dd MMM yyyy HH:mm:ss zzz"
        return dateFormatter.string(from: self)
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

extension Date {
    var hourPrint: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: self)
    }
    
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: self)
    }
}
