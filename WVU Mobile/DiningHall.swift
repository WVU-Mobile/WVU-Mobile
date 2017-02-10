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
        
        return "https://diningmenuservice.wvu.edu/\(self.rawValue)/\(components.month!)/\(components.day!)/\(components.year!)/1410376600000/?callback="
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
    
    var isOpen: Bool {
        // check if holiday or outside semester hours
        
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.init(abbreviation: "EST")!
        
        let date = Date()

        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let weekday = calendar.component(.weekday, from: date)
        
        switch self {
        case .Arnold:
            if calendar.isDateInWeekend(date) {
                if hour >= 11 && hour < 15 {
                    return true
                }
            } else {
                if hour >= 9 && hour < 19 {
                    return true
                }
            }
        case .Summit:
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
        case .Boreman:
            if calendar.isDateInWeekend(date) {
                if hour >= 11 && hour < 15 {
                    return true
                }
            } else {
                if hour >= 7 && hour < 19 {
                    return true
                }
            }
        case .Hatfields:
            if !calendar.isDateInWeekend(date) {
                if ((hour == 7 && minute >= 15) || (hour >= 8) ) && hour < 10 {
                    return true
                } else if hour >= 11 && hour < 2 {
                    return true
                }
            }
        case .TerraceRoom:
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
        case .CafeEvansdale:
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
        case .Arnold:
            return  "Monday – Friday 9:00am to 7:00pm\n" +
                    "Saturday & Sunday 11:00 am - 3:00 pm"
        case .CafeEvansdale:
            return  "Monday - Thursday 7:00 am – 8:00 pm\n" +
                    "Friday 7:00 am – 6:30 pm\n" +
                    "Saturday & Holidays 9:00 am – 6:30 pm\n" +
                    "Sunday 9:00 am – 7:30 pm"
        case .Summit:
            return  "Monday – Friday 7:00 am - 7:00 pm\n" +
                    "Saturday, Sunday & Holidays 11:00 am - 6:30 pm"
        case .Boreman:
            return  "Monday - Friday 11:00 am - 7:00 pm\n" +
                    "Saturday & Sunday 11:00 am - 3:00 pm"
        case .TerraceRoom:
            return  "Monday – Thursday 11:00 am - 8:00 pm\n" +
                    "Friday 11:00 am - 2:00 pm\n" +
                    "Saturday, Sunday & Holidays Closed"
        case .Hatfields:
            return  "Breakfast: 7:15 am - 10:00 am\n" +
                    "Lunch: 11:00 am - 2:00 pm\n" +
                    "Saturday, Sunday & Holidays Closed"
        }
    }
    
    var meals: [Menu.Meal] {
        switch self {
        case .Arnold,  .CafeEvansdale, .Summit, .Boreman :
            return  [.breakfast, .lunch, .dinner]
        case .TerraceRoom:
            return   [.lunch, .dinner]
        case .Hatfields:
            return  [.breakfast, .lunch]
        }
    }
    
    var description: String {
        switch self {
        case .Arnold:
            return  "Cafe Evansdale is located in Brooke Tower and serves breakfast, lunch, and dinner."
        case .CafeEvansdale:
            return  "Cafe Evansdale is located in Brooke Tower and serves breakfast, lunch, and dinner."
        case .Summit:
            return  "Summit Cafe is located in Summit Hall and serves breakfast, lunch, and dinner"
        case .Boreman:
            return  "Boreman is located in Boreman Hall and serves lunch and dinner."
        case .TerraceRoom:
            return  "The Terrace Room is located in Stalnaker Hall and serves lunch and dinner."
        case .Hatfields:
            return  "Hatfields is located in the Mountainlair and serves breakfast and lunch. They only accept dining plans for breakfast."
        }
    }
    
    var latitude: Double {
        switch self {
        case .Arnold:
            return 39.632444
        case .CafeEvansdale:
            return 39.648935
        case .Summit:
            return 39.638829
        case .Boreman:
            return 39.633060
        case .TerraceRoom:
            return 39.635357
        case .Hatfields:
            return 39.634752
        }
    }
    
    var longitude: Double {
        switch self {
        case .Arnold:
            return -79.950319
        case .CafeEvansdale:
            return -79.966303
        case .Summit:
            return -79.956533
        case .Boreman:
            return -79.952642
        case .TerraceRoom:
            return -79.952755
        case .Hatfields:
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
