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
        return true
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
                    "Saturday, Sunday & Holidays Closed"
        case .Hatfields:
            return  "Breakfast: 7:15 am - 10:00 am\n" +
                    "Lunch: 11:00 am - 2:00 pm\n" +
                    "Saturday, Sunday & Holidays Closed"
        }
    }
    
    var meals: [Menu.Meal] {
        switch self {
        case .Arnold,  .CafeEvansdale, .Summit:
            return  [.breakfast, .lunch, .dinner]
        case .Boreman,  .TerraceRoom:
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
}
