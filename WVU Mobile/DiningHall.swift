//
//  DiningHall.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/18/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import Foundation

enum DiningHall: Int {
    case cafeEvansdale = 1
    case summit = 2
    case boreman = 4
    case terraceRoom = 5
    case hatfields = 6
    
    var campus: String {
        switch self {
        case .cafeEvansdale:
            return "Evansdale"
        default:
            return "Downtown"
        }
    }
    
    func url(on date: Date) -> String {
        let components = NSCalendar.current.dateComponents([.day, .month, .year], from: date)
        
        return "https://diningmenuservice.wvu.edu/\(self.rawValue)/\(components.month!)/\(components.day!)/\(components.year!)/1410376600000/?callback="
    }
    
    var name: String {
        switch self {
        case .cafeEvansdale:
            return "Cafe Evansdale"
        case .summit:
            return "Summit"
        case .boreman:
            return "Boreman"
        case .terraceRoom:
            return "Terrace Room"
        case .hatfields:
            return "Hatfields"
        }
    }
    
    var isOpen: Bool {
        // check if holiday or outside semester hours
        
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.init(abbreviation: "EST")!
        
        let date = Date()

        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let weekday = calendar.component(.weekday, from: date)
        
        switch self {
        case .summit:
            if calendar.isDateInWeekend(date) {
                if hour >= 11 && hour < 18 {
                    if hour == 18 {
                        if minute < 30 {
                            return true
                        }
                    } else {
                        return true
                    }
                }
            } else {
                if hour >= 7 && hour < 19 {
                    return true
                }
            }
        case .boreman:
            if calendar.isDateInWeekend(date) {
                if hour >= 11 && hour < 15 {
                    return true
                }
            } else {
                if hour >= 7 && hour < 19 {
                    return true
                }
            }
        case .hatfields:
            if !calendar.isDateInWeekend(date) {
                if ((hour == 7 && minute >= 15) || (hour >= 8) ) && hour < 10 {
                    return true
                } else if hour >= 11 && hour < 2 {
                    return true
                }
            }
        case .terraceRoom:
            if !calendar.isDateInWeekend(date) {
                if weekday == 6 {
                    if hour >= 11 && hour < 14 {
                        return true
                    }
                } else {
                    if hour >= 11 && hour < 20 {
                        return true
                    }
                }
            }
        case .cafeEvansdale:
            if weekday == 1 {
                if hour >= 9 && ( hour < 19 || hour == 19 && minute <= 30 ) {
                    return true
                }
            } else if weekday == 6 {
                if hour >= 7 && ( hour < 18 || hour == 18 && minute <= 30 ) {
                    return true
                }
            } else if weekday == 7 {
                if hour >= 9 && ( hour < 18 || hour == 18 && minute <= 30 ) {
                    return true
                }
            } else {
                if hour >= 7 && hour < 20 {
                    return true
                }
            }
        }
        return false
    }
    
    var hoursOfOperation: String {
        switch self {
        case .cafeEvansdale:
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
        case .terraceRoom:
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
        case .cafeEvansdale, .summit, .boreman :
            return  [.breakfast, .lunch, .dinner]
        case .terraceRoom:
            return   [.lunch, .dinner]
        case .hatfields:
            return  [.breakfast, .lunch]
        }
    }
    
    var description: String {
        switch self {
        case .cafeEvansdale:
            return  "Cafe Evansdale is located in Brooke Tower and serves breakfast, lunch, and dinner."
        case .summit:
            return  "Summit Cafe is located in Summit Hall and serves breakfast, lunch, and dinner"
        case .boreman:
            return  "Boreman is located in Boreman Hall and serves lunch and dinner."
        case .terraceRoom:
            return  "The Terrace Room is located in Stalnaker Hall and serves lunch and dinner."
        case .hatfields:
            return  "Hatfields is located in the Mountainlair and serves breakfast and lunch. They only accept dining plans for breakfast."
        }
    }
    
    var latitude: Double {
        switch self {
        case .cafeEvansdale:
            return 39.648935
        case .summit:
            return 39.638829
        case .boreman:
            return 39.633060
        case .terraceRoom:
            return 39.635357
        case .hatfields:
            return 39.634752
        }
    }
    
    var longitude: Double {
        switch self {
        case .cafeEvansdale:
            return -79.966303
        case .summit:
            return -79.956533
        case .boreman:
            return -79.952642
        case .terraceRoom:
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
