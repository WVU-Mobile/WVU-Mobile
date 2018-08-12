//
//  DiningHall.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/18/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import Foundation

enum DiningHall: String {
    case evansdale
    case summit
    case boreman
    case terrace
    case hatfields
    
    var campus: String {
        switch self {
        case .evansdale:
            return "Evansdale"
        case .summit, .boreman, .terrace, .hatfields:
            return "Downtown"
        }
    }
    
    func url(on date: Date) -> String {
        return "https://f09bec8ldd.execute-api.us-east-1.amazonaws.com/stable/dining-menus/\(self.rawValue)\(date.apiFormat ?? "")"
        //return "https://f09bec8ldd.execute-api.us-east-1.amazonaws.com/stable/dining-menus/boreman20180423"
    }
    
    var name: String {
        switch self {
        case .evansdale:
            return "Cafe Evansdale"
        case .summit:
            return "Summit"
        case .boreman:
            return "Boreman"
        case .terrace:
            return "Terrace Room"
        case .hatfields:
            return "Hatfields"
        }
    }
    
    var isOpen: Bool {
        // TODO: check if holiday or outside semester hours
        guard let timeZone = TimeZone.init(abbreviation: "EST") else { return false }

        var calendar = Calendar.current
        calendar.timeZone = timeZone
        
        let date = Date()
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let weekday = calendar.component(.weekday, from: date)
        
        switch self {
        case .summit:
            return calendar.isDateInWeekend(date) ? hour >= 11 && hour < 18 || hour == 18 && minute < 30 : hour >= 7 && hour < 19
        case .boreman:
            return calendar.isDateInWeekend(date) ? hour >= 11 && hour < 15 : hour >= 7 && hour < 19
        case .hatfields:
            return !calendar.isDateInWeekend(date) ? ((hour == 7 && minute >= 15) || (hour >= 8) ) && hour < 10 || hour >= 11 && hour < 2 : false
        case .terrace:
            return !calendar.isDateInWeekend(date) ? weekday == 6 && hour >= 11 && hour < 14 || hour >= 11 && hour < 20 : false
        case .evansdale:
            return (weekday == 1 && hour >= 9 && (hour < 19 || hour == 19 && minute <= 30))
                || (weekday == 6 && hour >= 7 && (hour < 18 || hour == 18 && minute <= 30))
                || weekday == 7 && hour >= 9 && (hour < 18 || hour == 18 && minute <= 30)
                || hour >= 7 && hour < 20
        }
    }
    
    var hoursOfOperation: String {
        switch self {
        case .evansdale:
            return  "Monday - Thursday 7:00 am – 8:00 pm\n" +
                    "Friday 7:00 am – 6:30 pm\n" +
                    "Saturday & Holidays 9:00 am – 6:30 pm\n" +
                    "Sunday 9:00 am – 7:30 pm"
        case .summit:
            return  "Monday – Friday 7:00 am - 7:00 pm\n" +
                    "Saturday, Sunday & Holidays 11:00 am - 6:30 pm"
        case .boreman:
            return  "Monday - Friday 11:00 am - 7:00 pm\n" +
                    "Saturday & Sunday 11:00 am - 3:00 pm"
        case .terrace:
            return  "Monday – Thursday 11:00 am - 8:00 pm\n" +
                    "Friday 11:00 am - 2:00 pm\n" +
                    "Saturday, Sunday & Holidays Closed"
        case .hatfields:
            return  "Breakfast: 7:15 am - 10:00 am\n" +
                    "Lunch: 11:00 am - 2:00 pm\n" +
                    "Saturday, Sunday & Holidays Closed"
        }
    }
    
    var meals: [Menu.Meal] {
        switch self {
        case .evansdale, .summit, .boreman :
            return  [.breakfast, .lunch, .dinner]
        case .terrace:
            return   [.lunch, .dinner]
        case .hatfields:
            return  [.breakfast, .lunch]
        }
    }
    
    var description: String {
        switch self {
        case .evansdale:
            return  "Cafe Evansdale is located in Brooke Tower and serves breakfast, lunch, and dinner."
        case .summit:
            return  "Summit Cafe is located in Summit Hall and serves breakfast, lunch, and dinner"
        case .boreman:
            return  "Boreman is located in Boreman Hall and serves lunch and dinner."
        case .terrace:
            return  "The Terrace Room is located in Stalnaker Hall and serves lunch and dinner."
        case .hatfields:
            return  "Hatfields is located in the Mountainlair and serves breakfast and lunch. They only accept dining plans for breakfast."
        }
    }
    
    var latitude: Double {
        switch self {
        case .evansdale:
            return 39.648935
        case .summit:
            return 39.638829
        case .boreman:
            return 39.633060
        case .terrace:
            return 39.635357
        case .hatfields:
            return 39.634752
        }
    }
    
    var longitude: Double {
        switch self {
        case .evansdale:
            return -79.966303
        case .summit:
            return -79.956533
        case .boreman:
            return -79.952642
        case .terrace:
            return -79.952755
        case .hatfields:
            return -79.953916
        }
    }

    // price Pay at the Door (prices include sales tax):
    /*  Breakfast: 8.35
        Lunch/Brunch: 9.25
        Dinner: 11.25
     */
    
    enum Operational {
        case open, openingSoon, closed, closingSoon
        
        var isOpen: Bool {
            switch self {
            case .open, .closingSoon:
                return true
            default:
                return false
            }
        }
        
        var string: String {
            switch self {
            case .open:
                return "Open"
            case .openingSoon:
                return "Opening soon"
            case .closingSoon:
                return "Closing soon"
            case .closed:
                return "Closed"
            }
        }
        
    }
    
}

extension Date {
    var apiFormat: String? {
        let components = NSCalendar.current.dateComponents([.day, .month, .year], from: self)
        guard let month = components.month, let day = components.day, let year = components.year else { return nil }
        
        return String(format: "%d%02d%d", year, month, day)
    }
    
}
