//
//  BusesTableViewController.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 1/7/17.
//  Copyright © 2017 WVU Mobile. All rights reserved.
//

import UIKit
import MapKit

class BusesTableViewController: UITableViewController {
    let campusPM = BusLine(
        name: "1 - Campus PM",
        stops: ["Towers", "University and VanVoorhis", "Fieldcrest", "Ruby", "Med Center and Willowdale", "Willowdale and Valley View", "Valley View", "Valley View and Chestnut Ridge", "Chestnut Ridge and Stewartstown", "Kingston and Stewart", "Stewart and Hoffman", "Express Mart", "Stewart and University", "University and Falling Run", "E. Moore Hall", "Willey and University", "High and Willey", "Met Theatre", "High and Pleasant", "Pleasant and Spruce", "Public Safety Building", "Spruce Street", "Spruce and Willey", "High and Willey", "Willey and University", "Mountainlair", "Loop Area - University Ave", "Stewart and University", "University and Houston", "University and Beverly", "University and North", "Law School Drive", "Evansdale McDonalds"],
        hours: ["", "", "", "", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM"],
        semesters: "Fall & Spring Semesters Only",
        hoursString: "Thur. - Sat. 6:00 PM to 2:50 AM",
        runTime: "Run Time: ~30 - 50 minutes",
        twitter: "MLcampuspm")
    
    let downtownPM = BusLine(
        name: "2 - DT PM Mall",
        stops: ["Towers", "University and VanVoorhis", "Fieldcrest", "Ruby", "Willowdale", "Med Center and Willowdale", "Willowdale and Valley View", "Valley View", "Valley View and Chestnut Ridge", "Chestnut Ridge and Stewartstown", "Kingston and Stewart", "Stewart and Hoffman", "Express Mart", "Stewart and University", "University and Falling Run", "E. Moore Hall", "Willey and University", "High and Willey", "Spruce and Willey", "Unity Manor", "Arnold Apartments", "Boreman Hall", "High and Willey", "Met Theatre", "Warner Theater", "High and Foundry", "Foundry and University", "University and Pleasant", "Holland and River Road", "Holland and West Park", "Westover Circle K", "Westover Triangle", "Colasante's Shelter", "Westover Park and Ride", "Westover Terminal", "Fairmont & Riverview Rd", "Westover BP", "The Commons (Gabes)", "Morgantown Mall - Carmike Theater", "McDonald's Westover", "Ringer Law Office", "Westover Terminal", "Westover Rite Aid", "Westover Triangle", "Westover Circle K", "Holland and West Park", "Holland and River Road", "University and Pleasant", "High and Pleasant", "Pleasant and Spruce", "Public Safety Building", "Spruce Street", "Spruce and Willey", "Boreman Hall", "Mountainlair", "Loop Area - University Ave", "Stewart and University", "University and Houston", "University and Beverly", "University and North", "Law School Drive", "Evansdale McDonalds"],
        hours: ["", "", "", "", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM"],
        semesters: "",
        hoursString: "Mon. - Sat. 6:00 PM to 12:00 AM",
        runTime: "Run Time: ~60 minutes",
        twitter: "MLMallpm")
    
    let green = BusLine(
        name: "3 - Green Line",
        stops: ["Mountain Line Depot", "Waterfront", "South University Plaza", "Aldi", "Greenbag Road", "Morgantown Motel", "Comfort Inn", "Ramada Inn", "Job Service", "Wal-Mart University Ave", "Dorsey's Knob", "Morgantown Motel", "Greenbag Road", "Mountain Line Depot", "Foundry and University", "University and Pleasant", "Holland and River Road", "Holland and West Park", "Westover Triangle", "Colasante's Shelter", "Westover Park and Ride", "Westover Terminal", "Fairmont & Riverview Rd", "Westover BP", "The Commons (Gabes)", "Morgantown Mall - Carmike Theater", "Morgantown Mall Garfield's", "McDonald's Westover", "Big Lots", "Ringer Law Office", "Westover Terminal", "Westover Park and Ride", "Westover Rite Aid", "Westover Triangle", "Holland and West Park", "Holland and River Road", "University and Pleasant", "Foundry and University"],
        hours: ["", "", "", "", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM"],
        semesters: "",
        hoursString: "Mon. - Fri. 8:00 AM to 5:40 PM \n Sat. 9:00 AM to 5:40 PM",
        runTime: "Run Time: ~30 minutes",
        twitter: "ML03green")
    
    // North and South Routes + Even and Odd Hour Stops
    let orange = BusLine(
        name: "4 - Orange Line",
        stops: ["Mountain Line Depot", "Foundry and University", "University and Pleasant", "Holland and River Road", "Holland and West Park", "Westover Circle K", "Westover Triangle", "Colasante's Shelter", "Westover Terminal", "Fairmont & Riverview Rd", "Westover BP", "The Commons (Gabes)", "Morgantown Mall Garfield's", "Olive Garden/Red Lobster", "Barnes & Noble (UTC)", "Best Buy", "Giant Eagle", "Dick's Sporting Goods", "Wal-Mart - University Town Center", "Sam's Club", "Target (UTC)", "Old Navy (UTC)", "Hollywood Theaters", "The Domain Student Housing", "Cheddar's (UTC)", "Longhorn Steakhouse (UTC)", "Chili's (UTC)", "Star City CVS", "Texas Roadhouse", "WV State Police", "Coliseum", "Kroger - Patteson Dr.", "Towers", "Towers PRT", "Allen Hall", "Evansdale Library", "Engineering Loop", "Creative Arts Center", "Core Arboretum", "Beechurst and 8th", "Seneca Center", "Beechurst and 6th", "Beechurst and 3rd", "Beechurst and Campus", "Stansbury Hall", "University and Fayette", "Fayette and High", "Spruce Street", "Spruce and Willey", "Unity Manor", "Boreman Hall", "High and Willey", "Fayette and High", "Court House", "Mountain Line Depot", "Foundry and University", "University and Pleasant", "Warner Theater", "Pleasant and Spruce", "Cobun and Pleasant", "Cobun and Walnut", "Arch and Green", "Wilson and Overdale", "Wilson and Grand", "MHS", "Linden and Wilson", "Simpson and High", "South High and Dorsey", "Dorsey and Hite", "Dorsey and Ross", "Dorsey Lane", "Dorsey and Greenbag", "Bluegrass Village", "Greenbag and Mississippi", "Mountaineer Mall", "Greenbag and Mississippi", "MTEC", "White Park/Ice Rink", "White Park", "Hess and Standard", "Standard and Twigg", "Mississippi and Madigan", "Madigan and Barrickman", "South High and Dorsey", "Simpson and High", "Linden and Wilson", "MHS", "Wilson and Grand", "Wilson and Overdale", "Arch and Green", "Cobun and Walnut", "Public Safety Building", "Spruce Street", "Spruce and Willey", "Unity Manor", "Arnold Apartments", "Boreman Hall", "High and Willey", "Fayette and High", "Court House", "High and Pleasant", "Warner Theater", "High and Foundry", "Foundry and University", "Mountain Line Depot"],
        hours: ["", "", "", "", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM"],
        semesters: "",
        hoursString: "Mon. - Sat. 7:00 AM to 5:10 PM",
        runTime: "Run Time: ~113 minutes",
        twitter: "ML04orange")
    
    // Even + Odd Hour Stops
    let gold = BusLine(
        name: "6 - Gold Line",
        stops: ["Mountain Line Depot", "Foundry and University", "University and Pleasant", "Warner Theater", "High and Kirk St", "Pleasant and Spruce", "Public Safety Building", "Spruce Street", "Spruce and Willey", "Unity Manor", "Boreman Hall", "High and Prospect", "Mountainlair", "Loop Area - University Ave", "Stewart and University", "University and Houston", "University and Beverly", "University and North", "University and 8th St", "Law School Drive", "Evansdale McDonalds", "University and VanVoorhis", "Ruby", "Willowdale", "Pineview and JD Anderson", "North Hills", "Headlee and Pineview", "Pineview and JD Anderson", "Sundale", "Mon General", "Willowdale", "Ruby", "Fieldcrest", "University and VanVoorhis", "Evansdale McDonalds", "Law School Drive", "University and 8th St", "University and North", "University and Beverly", "University and Houston", "Stewart and University", "Loop Area - University Ave", "E. Moore Hall", "Willey and University", "High and Willey", "Fayette and High", "Court House", "High and Pleasant", "Warner Theater", "High and Kirk St", "High and Foundry", "Foundry and University", "Mountain Line Depot", "Foundry and University", "University and Pleasant", "Warner Theater", "High and Kirk St", "Pleasant and Spruce", "Public Safety Building", "Spruce Street", "Spruce and Willey", "Unity Manor", "Boreman Hall", "High and Prospect", "Mountainlair", "Loop Area - University Ave", "Stewart and University", "University and Houston", "University and Beverly", "University and North", "University and 8th St", "Law School Drive", "Evansdale McDonalds", "Towers", "University and VanVoorhis", "Fieldcrest", "Mountaineer Station", "BB&T", "Killarney and Van Voorhis", "Campus Evolution Villages", "West Run Rd & Van Voorhis Rd", "Baker's Ridge Road", "Independence Hills MHP", "Baker's Ridge Road", "West Run Rd & Van Voorhis Rd", "Baker's Ridge Road", "The Villages at West Run", "Riddle and West Run", "BB&T", "Mountaineer Station", "University and VanVoorhis", "Towers", "Evansdale McDonalds", "Law School Drive", "University and 8th St", "University and North", "University and Beverly", "University and Houston", "Stewart and University", "Loop Area - University Ave", "E. Moore Hall", "Willey and University", "High and Willey", "Fayette and High", "Court House", "High and Pleasant", "Warner Theater", "High and Kirk St", "High and Foundry", "Foundry and University", "Mountain Line Depot"],
        hours: ["", "", "", "", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM"],
        semesters: "",
        hoursString: "Mon. - Fri. 6:00 AM to 5:10 PM \n Sat. 7:00 AM to 5:10 PM",
        runTime: "Run Time: ~80 minutes",
        twitter: "ML06gold")
    
    let red = BusLine(
        name: "7 - Red Line",
        stops: ["Mountain Line Depot", "Foundry and University", "High and Foundry", "Pleasant and Spruce", "Public Safety Building", "Spruce Street", "Spruce and Willey", "Unity Manor", "Boreman Hall", "High and Prospect", "Mountainlair", "Loop Area - University Ave", "Stewart and University", "University and Houston", "University and Beverly", "University and North", "Law School Drive", "Evansdale McDonalds", "Towers", "University and VanVoorhis", "University and Collins Ferry", "University and Junior", "Junior and Fairfield", "Fairfield and Mansfield", "Congress and Fairfield", "Kensington and Fenwick", "Fenwick and Harvard", "Western", "Lawnview", "Lawnview and Collins Ferry", "FETC", "Timberline", "Lawnview and Collins Ferry", "Collins Ferry and Aspen", "Anderson", "Colonial", "Killarney and Van Voorhis", "BB&T", "Mountaineer Station", "University and VanVoorhis", "Towers", "Evansdale McDonalds", "Law School Drive", "University and North", "University and Beverly", "University and Houston", "Stewart and University", "University and Falling Run", "E. Moore Hall", "Willey and University", "High and Willey", "Met Theatre", "Court House", "High and Pleasant", "Warner Theater", "High and Foundry", "Foundry and University"],
        hours: ["", "", "", "", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM"],
        semesters: "",
        hoursString: "Mon. - Fri. 6:20 AM to 5:10 PM \n Sat. 7:30 AM to 3:40 PM",
        runTime: "Run Time: ~70 minutes",
        twitter: "ML07red")
    
    let tyrone = BusLine(
        name: "8 - Tyrone",
        stops: ["Mountain Line Depot", "Foundry and University", "High and Foundry", "Pleasant and Spruce", "Public Safety Building", "Spruce Street", "Spruce and Willey", "Unity Manor", "Richwood", "Richwood and Dayton", "Richwood and Charles", "Richwood and Elkins", "Richwood Dairy Mart", "DMV", "Ford Garage", "Sabraton Plaza", "Walgreen's Sabraton", "Hardees", "Kroger - Rt. 7 Sabraton", "Listravia", "Rock Forge Community House", "Rt 7 and Circle K", "Summer School Road", "Richard", "Dellslow", "Hagedorns", "Tyrone Road", "Maple Leaf Lane", "Tyrone and Pierpont", "Breezewood", "Snake Hill", "Tyrone and Tyrone-Avery", "Tyrone Avery", "Cheat Avery", "Rolling Hills", "Deerwood Village", "Tyrone and Old Cheat", "Cheat Lake Bridge", "Lakeview", "Ashbrook", "Cheat Lake Fire Hall", "Skyview", "Mon-Fayette Industrial Park", "Sunset Beach", "Tibbs", "Brookhaven United Methodist", "Pleasant Hill Road", "Brookview Apartments", "Twin Maples MHP", "Brookview Apartments", "Brookhaven", "Hardees", "Walgreen's Sabraton", "Advanced Auto Sabraton", "Sabraton Plaza", "Marilla Park", "Court House", "High and Pleasant", "Warner Theater", "High and Kirk St", ],
        hours: ["", "", "", "", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM"],
        semesters: "",
        hoursString: "Mon. - Fri. 6:30 AM to 5:10 PM \n Sat. 8:00 AM to 5:10 PM",
        runTime: "Run Time: ~90 minutes",
        twitter: "ML08tyrone")
    
    let purple = BusLine(
        name: "9 - Purple Line",
        stops: ["Mountain Line Depot", "Foundry and University", "High and Foundry", "Pleasant and Spruce", "Public Safety Building", "Spruce Street", "Spruce and Willey", "High and Willey", "Willey and University", "Mountainlair", "University and Falling Run", "Loop Area - University Ave", "Stewart and University", "Express Mart", "Stewart & Protzman", "Shorty Anderson's", "Lewis Street", "Chestnut Ridge and Stewartstown", "Valley View and Chestnut Ridge", "Chestnut Hill Apartments", "Willowdale", "Med Center and Willowdale", "Willowdale and Valley View", "Valley View", "Valley View and Chestnut Ridge", "Chestnut Ridge and Stewartstown", "Stewart Place", "Kingston and Stewart", "Stewart and Hoffman", "Express Mart", "Stewart and University", "Loop Area - University Ave", "E. Moore Hall", "Willey and University", "University and Fayette", "University and Pleasant"],
        hours: ["", "", "", "", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM"],
        semesters: "",
        hoursString: "Mon. - Sat. 7:00 AM to 5:10 PM",
        runTime: "Run Time: ~40 minutes",
        twitter: "MLpurplepink")
    
    let cassville = BusLine(
        name: "11 - Cassville",
        stops: ["Mountain Line Depot", "Foundry and University", "University and Pleasant", "Walnut Street Parking Garage", "Walnut PRT", "Holland and River Road", "Holland and West Park", "Westover Circle K", "Westover Triangle", "Westover VFW", "Frank's Place", "Dunkard and Park", "Dunkard and Snider", "Dunkard and Wheeling", "Hometown Hotdog", "Dent's Run and Main Street", "Granville VFD", "Granville Park and Ride", "Riverfront Park", "Bertha Hill", "Osage Community Center", "Shack Neighborhood House", "Jere", "Cassville", "New Hill", "Olive Garden/Red Lobster", "Best Buy", "Giant Eagle", "Dick's Sporting Goods", "Wal-Mart - University Town Center", "Sam's Club", "Target (UTC)", "Old Navy (UTC)", "Hollywood Theaters", "The Domain Student Housing", "Cheddar's (UTC)", "Longhorn Steakhouse (UTC)", "Chili's (UTC)"],
        hours: ["", "", "", "", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM"],
        semesters: "",
        hoursString: "Mon. - Fri. 6:00 AM to 5:10 PM \n Sat. 8:00 AM to 4:00 PM",
        runTime: "Run Time: ~60 minutes",
        twitter: "ML11cass")
    
    let blue = BusLine(
        name: "12 - Blue Line",
        stops: ["Mountain Line Depot", "Foundry and University", "High and Foundry", "Pleasant and Spruce", "Public Safety Building", "Spruce Street", "Spruce and Willey", "Unity Manor", "Arnold Apartments", "Richwood", "Richwood and Dayton", "Richwood and Charles", "Richwood and Elkins", "Richwood Dairy Mart", "Hartman Run Road", "Woodland Terrace", "Airport", "Airport Office Park", "Mileground Honda", "Easton Hill School", "Canyon Circle K", "Fairfield Manor", "University High School", "Fairfield Manor", "Lakeside Canyon", "Canyon MHP", "Crest Point", "Glenmark Center", "Easton Hill School", "Mileground Honda", "Airport Office Park", "Airport", "Woodland Terrace", "Hartman Run Road", "Richwood Dairy Mart", "High and Willey", "Met Theatre", "Court House", "High and Pleasant", "University and Pleasant"],
        hours: ["", "", "", "", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM"],
        semesters: "",
        hoursString: "Mon. - Fri. 6:30 AM to 5:10 PM \n Sat. 8:00 AM to 4:00 PM",
        runTime: "Run Time: ~55 minutes",
        twitter: "ML12blue")
    
    let crown = BusLine(
        name: "13 - Crown",
        stops: ["Mountain Line Depot", "Foundry and University", "University and Pleasant", "Holland and River Road", "Holland and West Park", "Westover Circle K", "Westover Triangle", "Colasante's Shelter", "Westover Terminal", "Fairmont & Riverview Rd", "Westover BP", "Laurel Point", "Arnettsville Elementary", "Crown Turnaround", "Everettsville", "Opekisika Dam", "Lawlis Road", "National Church", "Booth", "River Road VFD", "Price Hill", "Westwood Middle School", "DuPont and River Road", "Westover Town Hall", "Westover Park and Ride", "Westover Rite Aid"],
        hours: ["", "", "", "", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM"],
        semesters: "",
        hoursString: "Mon. - Sat. 7:00 AM to 5:15 PM",
        runTime: "Run Time: ~70 minutes",
        twitter: "ML10brown")
    
    let mountainHeights = BusLine(
        name: "14 - Mtn. Heights",
        stops: ["Mountain Line Depot", "Foundry and University", "High and Foundry", "Pleasant and Spruce", "Public Safety Building", "Marilla Park", "Ford Garage", "Sabraton Plaza", "Walgreen's Sabraton", "Hardees", "Kroger - Rt. 7 Sabraton", "Listravia", "Brookhaven", "Rock Forge Community House", "Summer School Road", "Rt 7 and Circle K", "Eastgate", "Nicholson Loop", "Kingwood Pike", "Mountain View", "Kennedy Store", "Meadow Green", "Dorsey and Greenbag", "Bluegrass Village", "Greenbag and Mississippi", "Mountaineer Mall", "Eddie's Tire", "DMV", "Marilla Park", "Public Safety Building", "Court House", "High and Pleasant", "High and Kirk St", "High and Foundry", "Foundry and University"],
        hours: ["", "", "", "", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM"],
        semesters: "",
        hoursString: "Mon. - Fri. 8:05 AM to 4:15 PM \n Sat. 8:05 AM to 2:05 PM",
        runTime: "Run Time: ~30 - 55 minutes",
        twitter: "ML10brown")
    
    let graftonRoad = BusLine(
        name: "15 - Grafton Rd.",
        stops: ["Mountain Line Depot", "Foundry and University", "South University Plaza", "Aldi", "Greenbag Road", "Morgantown Motel", "Ashton Estates", "Old Farm Road", "Goshen Rd Exit", "Halleck Road", "Tom's Run Road", "Triune-Halleck VFD", "Brown's Chapel", "Healthy Heights", "Dairy Mart Grafton Rd", "Clinton VFD", "O.J. White", "Wal-Mart University Ave", "Comfort Inn", "Dorsey's Knob"],
        hours: ["", "", "", "", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM"],
        semesters: "",
        hoursString: "Mon. - Sat. 9:10 AM to 3:05 PM",
        runTime: "Run Time: ~70 minutes",
        twitter: "ML10brown")
    
    let pink = BusLine(
        name: "16 - Pink Line",
        stops: ["Mountain Line Depot", "Foundry and University", "High and Foundry", "Pleasant and Spruce", "Public Safety Building", "Spruce Street", "Spruce and Willey", "Unity Manor", "Town Hill Grocery", "City Garden Apartments", "Mileground Health Care", "John Howard Motors", "Mileground Honda", "Easton Hill School", "Glenmark Center", "Lowes, Glenmark Center", "Michaels, Glenmark Center", "Arnold Apartments", "High and Willey", "Met Theatre", "Court House", "High and Pleasant", "Warner Theater"],
        hours: ["", "", "", "", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM"],
        semesters: "",
        hoursString: "Mon. - Fri. 7:40 AM to 4:20 PM \n Sat. 7:00 AM to 5:10 PM",
        runTime: "Run Time: ~40 minutes",
        twitter: "MLpurplepink")
    
    let grey = BusLine(
        name: "29 - Grey Line",
        stops: ["Westover Terminal", "Fairmont Gateway", "Clarksburg United Hospital", "Saltwell", "Westover Terminal", "Mountain Line Depot", "Mountaineer Station", "Waynesburg", "Pittsburgh Airport", "Pittsburgh Greyhound", "Towers"],
        hours: ["", "", "", "", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM"],
        semesters: "",
        hoursString: "Trip 1: Southbound 6:15 AM to Northbound 7:55 AM \n Trip 2: Southbound 12:30 PM to Northbound 5:20 PM",
        runTime: "Runs Twice Daily",
        twitter: "ML29grey")
    
    let westRun = BusLine(
        name: "30 - West Run",
        stops: ["West Run Apartments", "Copper Beech", "Stewartstown & West Run Rd", "Stewart & Glenmark Ave", "Bon Vista", "Cedarwood Drive", "Hampton Center", "Chestnut Ridge and Stewartstown", "Stewart Place", "Kingston and Stewart", "Stewart and Hoffman", "Square at Falling Run", "University and Falling Run", "Loop Area - University Ave", "Stewart and University", "Express Mart", "Shorty Anderson's", "Lewis Street"],
        hours: ["", "", "", "", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM"],
        semesters: "",
        hoursString: "Mon. - Fri. 7:10 AM to 4:50 PM (Summer & Winter Breaks)\nMon. - Wed. 7:10 AM to 8:40 PM (Fall & Spring Sem.)",
        runTime: "Run Time: ~20 - 30 minutes",
        twitter: "ML30wr")
    
    let westRunLate = BusLine(
        name: "30 - WR Late",
        stops: ["West Run Apartments", "Copper Beech", "Stewartstown & West Run Rd", "Stewart & Glenmark Ave", "Bon Vista", "Cedarwood Drive", "Hampton Center", "Chestnut Ridge and Stewartstown", "Stewart Place", "Kingston and Stewart", "Stewart and Hoffman", "Express Mart", "Stewart and University", "Loop Area - University Ave", "University and Falling Run", "E. Moore Hall", "Willey and University", "High and Willey", "Fayette and High", "Met Theatre", "Court House", "High and Pleasant", "Pleasant and Spruce", "Public Safety Building", "Spruce Street", "Spruce and Willey", "Mountainlair", "Shorty Anderson's", "Lewis Street"],
        hours: ["", "", "", "", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM"],
        semesters: "",
        hoursString: "Thur. - Sat. 7:10 AM to 2:30 AM",
        runTime: "Run Time: ~20 - 30 minutes",
        twitter: "ML30wr")
    
    let blueAndGold = BusLine(
        name: "38 - Blue & Gold",
        stops: ["Towers", "Evansdale McDonalds", "Law School Drive", "Grant and 6th", "4th Street", "Grant & 1st", "Beechurst and Campus", "Beechurst and 3rd", "Beechurst and 6th", "Beechurst and 8th", "Creative Arts Center", "Engineering Loop", "Evansdale Library", "Allen Hall"],
        hours: ["", "", "", "", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM"],
        semesters: "",
        hoursString: "Mon. - Fri. 6:40 AM to 8:40 PM (Fall & Spring) \n Mon. - Fri. 6:40 AM to 6:20 PM (Summer) \n Sat. 3:20 PM to 7:20 PM \n Sun. 12:00 PM to 8:40 PM",
        runTime: "Run Time: ~20 minutes",
        twitter: "ML38bg")
    
    let valleyView = BusLine(
        name: "44 - Valley View",
        stops: ["Valley View", "Valley View and Chestnut Ridge", "Chestnut Ridge and Stewartstown", "Stewart Place", "Kingston and Stewart", "Stewart & Protzman", "Square at Falling Run", "University and Falling Run", "Loop Area - University Ave", "Stewart and University", "Willowdale and Junction", "Willowdale and Valley View"],
        hours: ["", "", "", "", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM", "6:00 PM - 2:50 AM"],
        semesters: "",
        hoursString: "Mon. - Fri. 7:30 AM to 2:15 PM",
        runTime: "Run Time: ~15 minutes",
        twitter: "ML44vv")
    
    var routes = [BusLine]()
    
    let coords = [
        "Westover Terminal" : CLLocationCoordinate2DMake(39.632401, -79.976609),
        "Mountain Line Depot" : CLLocationCoordinate2DMake(39.629058, -79.959798),
        "Public Safety Building" : CLLocationCoordinate2DMake(39.62953608, -79.95487922),
        "Mountainlair" : CLLocationCoordinate2DMake(39.6348068, -79.95453651),
        "Stewart and University" : CLLocationCoordinate2DMake(39.637653, -79.954808),
        "Towers" : CLLocationCoordinate2DMake(39.648972, -79.966353),
        "Ruby" : CLLocationCoordinate2DMake(39.65186572, -79.9556238),
        "Medical Arts/Van Voorhis" : CLLocationCoordinate2DMake(39.66362218, -79.96297366),
        "Independence Hills MHP" : CLLocationCoordinate2DMake(39.675744, -79.961104),
        "Baker's Ridge Road" : CLLocationCoordinate2DMake(39.67429155, -79.95543803),
        "West Run Rd & Van Voorhis Rd" : CLLocationCoordinate2DMake(39.6694789, -79.9588979),
        "North Hills" : CLLocationCoordinate2DMake(39.666604, -79.951465),
        "Mon General" : CLLocationCoordinate2DMake(39.663677, -79.945871),
        "E. Moore Hall" : CLLocationCoordinate2DMake(39.63471149, -79.95462246),
        "High and Kirk St" : CLLocationCoordinate2DMake(39.627928, -79.957531),
        "Mountain Valley Apts" : CLLocationCoordinate2DMake(39.67488165, -79.96623654),
        "University and 8th St" : CLLocationCoordinate2DMake(39.64747079, -79.95978666),
        "Summit Hall" : CLLocationCoordinate2DMake(39.63879174, -79.95626822),
        "Grant and Campus" : CLLocationCoordinate2DMake(39.63735509, -79.9556868),
        "Beechurst and 6th" : CLLocationCoordinate2DMake(39.6411466, -79.9614916),
        "Grant and 6th" : CLLocationCoordinate2DMake(39.642438, -79.959895),
        "Creative Arts Center" : CLLocationCoordinate2DMake(39.64738416, -79.97642052),
        "Engineering Loop" : CLLocationCoordinate2DMake(39.64712054, -79.97442554),
        "Mountaineer Mall" : CLLocationCoordinate2DMake(39.606488, -79.962242),
        "Eddie's Tire" : CLLocationCoordinate2DMake(39.612252, -79.932008),
        "DMV" : CLLocationCoordinate2DMake(39.628515, -79.933403),
        "Woodland Terrace" : CLLocationCoordinate2DMake(39.635073, -79.925093),
        "Airport" : CLLocationCoordinate2DMake(39.644041, -79.920093),
        "Canyon Circle K" : CLLocationCoordinate2DMake(39.667478, -79.918111),
        "Lakeside Canyon" : CLLocationCoordinate2DMake(39.676678, -79.891475),
        "Canyon MHP" : CLLocationCoordinate2DMake(39.67171022, -79.89000536),
        "Glenmark Center" : CLLocationCoordinate2DMake(39.64851433, -79.90118847),
        "Westover Triangle" : CLLocationCoordinate2DMake(39.63466337, -79.96983061),
        "Laurel Point" : CLLocationCoordinate2DMake(39.6193, -80.0299),
        "Opekisika Dam" : CLLocationCoordinate2DMake(39.5636, -80.0527),
        "Everettsville" : CLLocationCoordinate2DMake(39.5631, -80.0674),
        "Arnettsville Elementary" : CLLocationCoordinate2DMake(39.5828, -80.0943),
        "Crown Turnaround" : CLLocationCoordinate2DMake(39.582992, -80.102824),
        "Lawlis Road" : CLLocationCoordinate2DMake(39.580102, -80.061953),
        "Booth" : CLLocationCoordinate2DMake(39.597175, -80.015413),
        "River Road VFD" : CLLocationCoordinate2DMake(39.5988, -80.0075),
        "Willowdale" : CLLocationCoordinate2DMake(39.65475056, -79.95330022),
        "Boreman Hall" : CLLocationCoordinate2DMake(39.63333543, -79.95301548),
        "High and Pleasant" : CLLocationCoordinate2DMake(39.6288171, -79.95675082),
        "Morgantown Mall - Carmike Theater" : CLLocationCoordinate2DMake(39.6271177, -79.99942403),
        "The Commons (Gabes)" : CLLocationCoordinate2DMake(39.63053439, -80.00195061),
        "Tom's Run Road" : CLLocationCoordinate2DMake(39.5129, -79.9954),
        "Halleck Road" : CLLocationCoordinate2DMake(39.521, -80.0158),
        "Goshen Rd Exit" : CLLocationCoordinate2DMake(39.538439, -79.99489),
        "Ashton Estates" : CLLocationCoordinate2DMake(39.5842, -79.98),
        "Triune-Halleck VFD" : CLLocationCoordinate2DMake(39.4999, -79.9878),
        "Brown's Chapel" : CLLocationCoordinate2DMake(39.4927, -79.919),
        "Healthy Heights" : CLLocationCoordinate2DMake(39.51441, -79.909808),
        "Dairy Mart Grafton Rd" : CLLocationCoordinate2DMake(39.523766, -79.91413),
        "Clinton VFD" : CLLocationCoordinate2DMake(39.55621505, -79.9397902),
        "Wal-Mart University Ave" : CLLocationCoordinate2DMake(39.57917898, -79.95872716),
        "Fairmont & Riverview Rd" : CLLocationCoordinate2DMake(39.63257696, -79.98231763),
        "Westover BP" : CLLocationCoordinate2DMake(39.63081151, -79.98484424),
        "Morgantown Mall Garfield's" : CLLocationCoordinate2DMake(39.62702711, -79.99689503),
        "McDonald's Westover" : CLLocationCoordinate2DMake(39.63087276, -79.98463759),
        "Ramada Inn" : CLLocationCoordinate2DMake(39.58663235, -79.95747602),
        "Job Service" : CLLocationCoordinate2DMake(39.58649913, -79.96573442),
        "Dorsey's Knob" : CLLocationCoordinate2DMake(39.59540926, -79.95712993),
        "Sabraton Plaza" : CLLocationCoordinate2DMake(39.628231, -79.929977),
        "Rock Forge Community House" : CLLocationCoordinate2DMake(39.607581, -79.917296),
        "Rt 7 and Circle K" : CLLocationCoordinate2DMake(39.604411, -79.915775),
        "Summer School Road" : CLLocationCoordinate2DMake(39.604022, -79.914464),
        "Kingwood Pike" : CLLocationCoordinate2DMake(39.5415, -79.8728),
        "Wal-Mart - University Town Center" : CLLocationCoordinate2DMake(39.645575, -79.999286),
        "Star City CVS" : CLLocationCoordinate2DMake(39.65728761, -79.9903502),
        "Coliseum" : CLLocationCoordinate2DMake(39.648836, -79.980522),
        "Seneca Center" : CLLocationCoordinate2DMake(39.641613, -79.9622305),
        "Fayette and High" : CLLocationCoordinate2DMake(39.63098263, -79.95491265),
        "Mileground Health Care" : CLLocationCoordinate2DMake(39.64029083, -79.93563219),
        "Mileground Honda" : CLLocationCoordinate2DMake(39.64927429, -79.92150984),
        "Easton Hill School" : CLLocationCoordinate2DMake(39.65215797, -79.91382172),
        "Arnold Apartments" : CLLocationCoordinate2DMake(39.6318604, -79.95071308),
        "Chestnut Hill Apartments" : CLLocationCoordinate2DMake(39.65470779, -79.95049339),
        "Valley View" : CLLocationCoordinate2DMake(39.65093392, -79.94950536),
        "Shorty Anderson's" : CLLocationCoordinate2DMake(39.64632581, -79.94472696),
        "University and Junior" : CLLocationCoordinate2DMake(39.656749, -79.976804),
        "Congress and Fairfield" : CLLocationCoordinate2DMake(39.66055963, -79.98458622),
        "Kensington and Fenwick" : CLLocationCoordinate2DMake(39.66104759, -79.98243459),
        "Lawnview and Collins Ferry" : CLLocationCoordinate2DMake(39.6660298, -79.97751856),
        "Timberline" : CLLocationCoordinate2DMake(39.66881552, -79.97728866),
        "Collins Ferry and Aspen" : CLLocationCoordinate2DMake(39.661703, -79.974421),
        "Killarney and Van Voorhis" : CLLocationCoordinate2DMake(39.659545, -79.963139),
        "South High and Dorsey" : CLLocationCoordinate2DMake(39.62206994, -79.96287433),
        "Wilson and Overdale" : CLLocationCoordinate2DMake(39.62375769, -79.94847959),
        "Dorsey and Ross" : CLLocationCoordinate2DMake(39.614932, -79.951733),
        "Dorsey Lane" : CLLocationCoordinate2DMake(39.610658, -79.949205),
        "Dorsey and Greenbag" : CLLocationCoordinate2DMake(39.607448, -79.944716),
        "White Park" : CLLocationCoordinate2DMake(39.61420076, -79.95795875),
        "Mississippi and Madigan" : CLLocationCoordinate2DMake(39.61555569, -79.96795517),
        "Campus Evolution Villages" : CLLocationCoordinate2DMake(39.667088, -79.95773),
        "Wedgewood" : CLLocationCoordinate2DMake(39.66538378, -79.96362024),
        "Chelsea Square" : CLLocationCoordinate2DMake(39.657355, -79.9634),
        "Health Department" : CLLocationCoordinate2DMake(39.65196657, -79.96202187),
        "Mountaineer Station" : CLLocationCoordinate2DMake(39.65462889, -79.96157048),
        "BB&T" : CLLocationCoordinate2DMake(39.658079, -79.963065),
        "Richwood and Dayton" : CLLocationCoordinate2DMake(39.62992234, -79.94442703),
        "Richard" : CLLocationCoordinate2DMake(39.606081, -79.908109),
        "Brookhaven" : CLLocationCoordinate2DMake(39.609183, -79.920539),
        "Maple Leaf Lane" : CLLocationCoordinate2DMake(39.61572899, -79.88263846),
        "Dellslow" : CLLocationCoordinate2DMake(39.6063, -79.8932),
        "Cheat Avery" : CLLocationCoordinate2DMake(39.6543, -79.884803),
        "Crest Point" : CLLocationCoordinate2DMake(39.64892267, -79.88942249),
        "Cheat Lake Fire Hall" : CLLocationCoordinate2DMake(39.680614, -79.840858),
        "Mon-Fayette Industrial Park" : CLLocationCoordinate2DMake(39.68560857, -79.83256978),
        "Lakeview" : CLLocationCoordinate2DMake(39.666307, -79.853678),
        "West Run Apartments" : CLLocationCoordinate2DMake(39.656948, -79.92547),
        "Express Mart" : CLLocationCoordinate2DMake(39.6422383, -79.949763),
        "Unity Manor" : CLLocationCoordinate2DMake(39.6314636, -79.95090175),
        "Court House" : CLLocationCoordinate2DMake(39.62954716, -79.95611524),
        "Fieldcrest" : CLLocationCoordinate2DMake(39.65274323, -79.96351664),
        "Pierpont" : CLLocationCoordinate2DMake(39.6509, -79.9627),
        "Stansbury Hall" : CLLocationCoordinate2DMake(39.63497437, -79.95661316),
        "Met Theatre" : CLLocationCoordinate2DMake(39.63066126, -79.95521481),
        "Beechurst PRT" : CLLocationCoordinate2DMake(39.63485411, -79.95653562),
        "Spruce Street" : CLLocationCoordinate2DMake(39.63057929, -79.95397249),
        "Warner Theater" : CLLocationCoordinate2DMake(39.6285152, -79.95703927),
        "Ringer Law Office" : CLLocationCoordinate2DMake(39.63272322, -79.98199981),
        "South University Plaza" : CLLocationCoordinate2DMake(39.615576, -79.969893),
        "Morgantown Motel" : CLLocationCoordinate2DMake(39.60212306, -79.96379444),
        "Town Hill Grocery" : CLLocationCoordinate2DMake(39.63437234, -79.94321726),
        "Richwood Dairy Mart" : CLLocationCoordinate2DMake(39.632799, -79.931701),
        "Richwood and Charles" : CLLocationCoordinate2DMake(39.63077911, -79.94263204),
        "Hartman Run Road" : CLLocationCoordinate2DMake(39.633228, -79.927722),
        "Ford Garage" : CLLocationCoordinate2DMake(39.629327, -79.931548),
        "Best Buy" : CLLocationCoordinate2DMake(39.650944, -80.003469),
        "Granville VFD" : CLLocationCoordinate2DMake(39.64504097, -79.9864507),
        "New Hill" : CLLocationCoordinate2DMake(39.66763295, -80.07193918),
        "Walnut Street Parking Garage" : CLLocationCoordinate2DMake(39.63031157, -79.95694356),
        "Spruce and Willey" : CLLocationCoordinate2DMake(39.63174774, -79.95297486),
        "White Park/Ice Rink" : CLLocationCoordinate2DMake(39.61086514, -79.95836591),
        "Greenbag Road" : CLLocationCoordinate2DMake(39.6051061, -79.96679754),
        "Hampton Center" : CLLocationCoordinate2DMake(39.65289669, -79.93657535),
        "Chestnut Ridge and Stewartstown" : CLLocationCoordinate2DMake(39.649393, -79.94184425),
        "Loop Area - University Ave" : CLLocationCoordinate2DMake(39.637519, -79.953583),
        "Willowdale and Junction" : CLLocationCoordinate2DMake(39.64259, -79.95023),
        "Fairmont Gateway" : CLLocationCoordinate2DMake(39.476544, -80.1359),
        "Clarksburg United Hospital" : CLLocationCoordinate2DMake(39.329008, -80.240161),
        "Waynesburg" : CLLocationCoordinate2DMake(39.8984, -80.1374),
        "Pittsburgh Greyhound" : CLLocationCoordinate2DMake(40.444628, -79.993336),
        "Pittsburgh Airport" : CLLocationCoordinate2DMake(40.4963, -80.2562),
        "Krepps Park" : CLLocationCoordinate2DMake(39.64957458, -79.97558044),
        "Burrough's Place" : CLLocationCoordinate2DMake(39.657708, -79.97068),
        "Beechurst and 8th" : CLLocationCoordinate2DMake(39.6423161, -79.9633777),
        "Unity House" : CLLocationCoordinate2DMake(39.6569, -79.9711),
        "Walnut PRT" : CLLocationCoordinate2DMake(39.62996183, -79.9569842),
        "University and Fayette" : CLLocationCoordinate2DMake(39.63195, -79.95659),
        "Engineering PRT" : CLLocationCoordinate2DMake(39.64714, -79.97297),
        "Towers PRT" : CLLocationCoordinate2DMake(39.64787674, -79.96783248),
        "Med Center Station PRT" : CLLocationCoordinate2DMake(39.65496696, -79.96127207),
        "Fairmont Court House" : CLLocationCoordinate2DMake(39.4848, -80.1433),
        "University Hospital" : CLLocationCoordinate2DMake(39.65447434, -79.95871498),
        "Kingwood Civic Center" : CLLocationCoordinate2DMake(39.4671, -79.6887),
        "Kingwood Court House" : CLLocationCoordinate2DMake(39.4721, -79.6876),
        "Reedsville" : CLLocationCoordinate2DMake(39.5103, -79.7987),
        "Masontown" : CLLocationCoordinate2DMake(39.5521, -79.7978),
        "Hagedorns" : CLLocationCoordinate2DMake(39.607974, -79.890354),
        "Riverfront Park" : CLLocationCoordinate2DMake(39.648582, -79.990277),
        "Waterfront" : CLLocationCoordinate2DMake(39.624559, -79.962298),
        "Bertha Hill" : CLLocationCoordinate2DMake(39.66123192, -79.99653327),
        "Pleasant and Spruce" : CLLocationCoordinate2DMake(39.6284065, -79.95586886),
        "High and Willey" : CLLocationCoordinate2DMake(39.63225222, -79.95393831),
        "Willey and University" : CLLocationCoordinate2DMake(39.633238, -79.955315),
        "University and Falling Run" : CLLocationCoordinate2DMake(39.63715, -79.953653),
        "University and Houston" : CLLocationCoordinate2DMake(39.63924426, -79.95555826),
        "University and Beverly" : CLLocationCoordinate2DMake(39.640697, -79.956278),
        "University and North" : CLLocationCoordinate2DMake(39.64514547, -79.95665834),
        "Law School Drive" : CLLocationCoordinate2DMake(39.64747748, -79.96051853),
        "Evansdale McDonalds" : CLLocationCoordinate2DMake(39.649394, -79.964125),
        "University and VanVoorhis" : CLLocationCoordinate2DMake(39.65162327, -79.9667088),
        "Willowdale and Valley View" : CLLocationCoordinate2DMake(39.65099196, -79.95302226),
        "Valley View and Chestnut Ridge" : CLLocationCoordinate2DMake(39.65087622, -79.94471183),
        "Kingston and Stewart" : CLLocationCoordinate2DMake(39.6461467, -79.944931),
        "Stewart and Hoffman" : CLLocationCoordinate2DMake(39.64264, -79.94774),
        "Med Center and Willowdale" : CLLocationCoordinate2DMake(39.6524174, -79.9533252),
        "Westover Rite Aid" : CLLocationCoordinate2DMake(39.63462938, -79.9702868),
        "Westover Circle K" : CLLocationCoordinate2DMake(39.634061, -79.967488),
        "Holland and River Road" : CLLocationCoordinate2DMake(39.631467, -79.961342),
        "University and Pleasant" : CLLocationCoordinate2DMake(39.62978, -79.95845),
        "High and Prospect" : CLLocationCoordinate2DMake(39.63312, -79.95318),
        "High and Foundry" : CLLocationCoordinate2DMake(39.627696, -79.957721),
        "Foundry and University" : CLLocationCoordinate2DMake(39.628161, -79.959778),
        "Holland and West Park" : CLLocationCoordinate2DMake(39.634005, -79.961331),
        "Big Lots" : CLLocationCoordinate2DMake(39.628115, -79.985012),
        "Aldi" : CLLocationCoordinate2DMake(39.612794, -79.970225),
        "Comfort Inn" : CLLocationCoordinate2DMake(39.5875913, -79.95476096),
        "Allen Hall" : CLLocationCoordinate2DMake(39.64654161, -79.96772264),
        "Evansdale Library" : CLLocationCoordinate2DMake(39.64456622, -79.97152474),
        "Core Arboretum" : CLLocationCoordinate2DMake(39.646658, -79.976664),
        "Beechurst and Campus" : CLLocationCoordinate2DMake(39.63732025, -79.95751323),
        "Osage McDonalds" : CLLocationCoordinate2DMake(39.657953, -80.002779),
        "Giant Eagle" : CLLocationCoordinate2DMake(39.649917, -80.004242),
        "Dick's Sporting Goods" : CLLocationCoordinate2DMake(39.648669, -80.003556),
        "Sam's Club" : CLLocationCoordinate2DMake(39.6473, -80.000166),
        "Target (UTC)" : CLLocationCoordinate2DMake(39.64947365, -80.00111952),
        "Olive Garden/Red Lobster" : CLLocationCoordinate2DMake(39.65479601, -80.00482779),
        "Chili's (UTC)" : CLLocationCoordinate2DMake(39.65489503, -80.00396336),
        "WV State Police" : CLLocationCoordinate2DMake(39.654172, -79.984522),
        "Kroger - Patteson Dr." : CLLocationCoordinate2DMake(39.65119662, -79.96840693),
        "MHS" : CLLocationCoordinate2DMake(39.62374617, -79.95653586),
        "Linden and Wilson" : CLLocationCoordinate2DMake(39.623683, -79.957331),
        "Simpson and High" : CLLocationCoordinate2DMake(39.624455, -79.960349),
        "Dorsey and Hite" : CLLocationCoordinate2DMake(39.61832113, -79.9628079),
        "Bluegrass Village" : CLLocationCoordinate2DMake(39.606308, -79.947466),
        "Greenbag and Mississippi" : CLLocationCoordinate2DMake(39.60828237, -79.95511046),
        "MTEC" : CLLocationCoordinate2DMake(39.61003396, -79.95702285),
        "Hess and Standard" : CLLocationCoordinate2DMake(39.615981, -79.962292),
        "Standard and Twigg" : CLLocationCoordinate2DMake(39.614997, -79.963094),
        "Madigan and Barrickman" : CLLocationCoordinate2DMake(39.62059419, -79.96360268),
        "Wilson and Grand" : CLLocationCoordinate2DMake(39.62374177, -79.95492282),
        "Arch and Green" : CLLocationCoordinate2DMake(39.62529084, -79.95082349),
        "Cobun and Walnut" : CLLocationCoordinate2DMake(39.6263223, -79.95300205),
        "Riddle and West Run" : CLLocationCoordinate2DMake(39.66856, -79.947756),
        "Headlee and Pineview" : CLLocationCoordinate2DMake(39.663047, -79.953983),
        "Pineview and JD Anderson" : CLLocationCoordinate2DMake(39.660876, -79.953269),
        "Sundale" : CLLocationCoordinate2DMake(39.661111, -79.948421),
        "Vandervort" : CLLocationCoordinate2DMake(39.65929, -79.951324),
        "Maple Drive" : CLLocationCoordinate2DMake(39.657318, -79.949809),
        "Suncrest Village" : CLLocationCoordinate2DMake(39.656828, -79.944397),
        "University and Collins Ferry" : CLLocationCoordinate2DMake(39.65414437, -79.96967008),
        "Junior and Fairfield" : CLLocationCoordinate2DMake(39.65915591, -79.97673749),
        "Fairfield and Mansfield" : CLLocationCoordinate2DMake(39.65969068, -79.98045629),
        "Fenwick and Harvard" : CLLocationCoordinate2DMake(39.66037618, -79.97769932),
        "Western" : CLLocationCoordinate2DMake(39.66389149, -79.97850342),
        "Lawnview" : CLLocationCoordinate2DMake(39.66708453, -79.98051373),
        "FETC" : CLLocationCoordinate2DMake(39.669522, -79.976814),
        "Anderson" : CLLocationCoordinate2DMake(39.663232, -79.969949),
        "Richwood" : CLLocationCoordinate2DMake(39.62976176, -79.94850244),
        "Richwood and Elkins" : CLLocationCoordinate2DMake(39.633565, -79.934796),
        "Hardees" : CLLocationCoordinate2DMake(39.625903, -79.926171),
        "Walgreen's Sabraton" : CLLocationCoordinate2DMake(39.626221, -79.9269),
        "Kroger - Rt. 7 Sabraton" : CLLocationCoordinate2DMake(39.622363, -79.923873),
        "Listravia" : CLLocationCoordinate2DMake(39.617306, -79.921687),
        "Pleasant Hill Road" : CLLocationCoordinate2DMake(39.612122, -79.907166),
        "Brookview Apartments" : CLLocationCoordinate2DMake(39.613031, -79.902006),
        "Twin Maples MHP" : CLLocationCoordinate2DMake(39.615606, -79.89654),
        "Tyrone Road" : CLLocationCoordinate2DMake(39.60960675, -79.88632661),
        "Tyrone and Pierpont" : CLLocationCoordinate2DMake(39.622878, -79.881983),
        "Breezewood" : CLLocationCoordinate2DMake(39.63727661, -79.86015052),
        "Snake Hill" : CLLocationCoordinate2DMake(39.63962, -79.858843),
        "Tyrone and Tyrone-Avery" : CLLocationCoordinate2DMake(39.64387, -79.859421),
        "Tibbs" : CLLocationCoordinate2DMake(39.654624, -79.861323),
        "Tyrone and Old Cheat" : CLLocationCoordinate2DMake(39.65952288, -79.86498811),
        "Deerwood Village" : CLLocationCoordinate2DMake(39.65677479, -79.87161426),
        "Lowes, Glenmark Center" : CLLocationCoordinate2DMake(39.650148, -79.894668),
        "Michaels, Glenmark Center" : CLLocationCoordinate2DMake(39.64902306, -79.89596451),
        "Skyview" : CLLocationCoordinate2DMake(39.68198734, -79.83895444),
        "Ashbrook" : CLLocationCoordinate2DMake(39.672508, -79.855785),
        "Tyrone Avery" : CLLocationCoordinate2DMake(39.646244, -79.876905),
        "Westover VFW" : CLLocationCoordinate2DMake(39.63538051, -79.97132028),
        "Frank's Place" : CLLocationCoordinate2DMake(39.635601, -79.971818),
        "Dunkard and Park" : CLLocationCoordinate2DMake(39.63765059, -79.97409078),
        "Dunkard and Snider" : CLLocationCoordinate2DMake(39.639266, -79.979583),
        "Dunkard and Wheeling" : CLLocationCoordinate2DMake(39.64008986, -79.98127213),
        "Hometown Hotdog" : CLLocationCoordinate2DMake(39.64213398, -79.98260953),
        "Dent's Run and Main Street" : CLLocationCoordinate2DMake(39.643033, -79.984684),
        "Granville Park and Ride" : CLLocationCoordinate2DMake(39.64870214, -79.99046125),
        "Osage Community Center" : CLLocationCoordinate2DMake(39.65895788, -80.00800502),
        "Shack Neighborhood House" : CLLocationCoordinate2DMake(39.66688817, -80.02236964),
        "Jere" : CLLocationCoordinate2DMake(39.66738198, -80.03530625),
        "Cassville" : CLLocationCoordinate2DMake(39.665427, -80.062766),
        "Airport Office Park" : CLLocationCoordinate2DMake(39.64306726, -79.92319517),
        "Westover Town Hall" : CLLocationCoordinate2DMake(39.62754584, -79.97919003),
        "DuPont and River Road" : CLLocationCoordinate2DMake(39.617517, -79.976045),
        "Westwood Middle School" : CLLocationCoordinate2DMake(39.614962, -79.979707),
        "Price Hill" : CLLocationCoordinate2DMake(39.60439, -79.9961),
        "National Church" : CLLocationCoordinate2DMake(39.583757, -80.037404),
        "Marilla Park" : CLLocationCoordinate2DMake(39.628213, -79.939388),
        "Eastgate" : CLLocationCoordinate2DMake(39.601858, -79.909921),
        "Nicholson Loop" : CLLocationCoordinate2DMake(39.57825, -79.890511),
        "Mountain View" : CLLocationCoordinate2DMake(39.54427372, -79.87526775),
        "Kennedy Store" : CLLocationCoordinate2DMake(39.57182914, -79.91534593),
        "Meadow Green" : CLLocationCoordinate2DMake(39.58973, -79.928873),
        "Old Farm Road" : CLLocationCoordinate2DMake(39.57569227, -79.99344887),
        "O.J. White" : CLLocationCoordinate2DMake(39.56341256, -79.94319483),
        "Stewartstown & West Run Rd" : CLLocationCoordinate2DMake(39.6585161, -79.93056114),
        "Bon Vista" : CLLocationCoordinate2DMake(39.65459239, -79.93409859),
        "4th Street" : CLLocationCoordinate2DMake(39.64087842, -79.95811775),
        "Beechurst and 3rd" : CLLocationCoordinate2DMake(39.6388661, -79.9586722),
        "Square at Falling Run" : CLLocationCoordinate2DMake(39.637474, -79.952592),
        "Brookhaven United Methodist" : CLLocationCoordinate2DMake(39.609903, -79.910989),
        "Westover Park and Ride" : CLLocationCoordinate2DMake(39.63075984, -79.97710898),
        "Cobun and Pleasant" : CLLocationCoordinate2DMake(39.62623831, -79.95498561),
        "Colonial" : CLLocationCoordinate2DMake(39.661106, -79.964599),
        "Riverside Commons" : CLLocationCoordinate2DMake(39.3949, -79.5909),
        "University High School" : CLLocationCoordinate2DMake(39.68769444, -79.92499364),
        "Fairfield Manor" : CLLocationCoordinate2DMake(39.67730776, -79.91925115),
        "Cedarwood Drive" : CLLocationCoordinate2DMake(39.65402564, -79.93507946),
        "Stewart & Glenmark Ave" : CLLocationCoordinate2DMake(39.657369, -79.932828),
        "Stewart Place" : CLLocationCoordinate2DMake(39.64765946, -79.94353647),
        "City Garden Apartments" : CLLocationCoordinate2DMake(39.63846846, -79.93731909),
        "Prete Building" : CLLocationCoordinate2DMake(39.65278015, -79.96808883),
        "Crockett's" : CLLocationCoordinate2DMake(39.657597, -79.983036),
        "Barnes & Noble (UTC)" : CLLocationCoordinate2DMake(39.65197634, -80.00471454),
        "Old Navy (UTC)" : CLLocationCoordinate2DMake(39.651072, -80.001839),
        "Hollywood Theaters" : CLLocationCoordinate2DMake(39.652561, -80.000586),
        "Cheddar's (UTC)" : CLLocationCoordinate2DMake(39.65402099, -80.005872),
        "Longhorn Steakhouse (UTC)" : CLLocationCoordinate2DMake(39.65455818, -80.00509892),
        "Texas Roadhouse" : CLLocationCoordinate2DMake(39.6556214, -79.98703145),
        "Mylan" : CLLocationCoordinate2DMake(39.658997, -79.958861),
        "Saltwell" : CLLocationCoordinate2DMake(39.3365, -80.221825),
        "Westover Admin Facility" : CLLocationCoordinate2DMake(39.631767, -79.97591081),
        "McDonald's Sabraton" : CLLocationCoordinate2DMake(39.622214, -79.923392),
        "Lewis Street" : CLLocationCoordinate2DMake(39.64771408, -79.94343645),
        "Morgantown Bible Church" : CLLocationCoordinate2DMake(39.614478, -79.892672),
        "Star City Post Office" : CLLocationCoordinate2DMake(39.657711, -79.983378),
        "University & Boyers" : CLLocationCoordinate2DMake(39.659133, -79.988942),
        "Copper Beech" : CLLocationCoordinate2DMake(39.65548568, -79.92585208),
        "Grant & 1st" : CLLocationCoordinate2DMake(39.638075, -79.956017),
        "Stewart & Protzman" : CLLocationCoordinate2DMake(39.642617, -79.947586),
        "FACT Transit Center" : CLLocationCoordinate2DMake(39.911889, -79.747067),
        "Park & Ride Lot 51/43" : CLLocationCoordinate2DMake(39.920569, -79.726289),
        "FACT Transfer Center" : CLLocationCoordinate2DMake(39.960314, -79.649739),
        "Airport at Hartman & Mileground" : CLLocationCoordinate2DMake(39.64945, -79.921247),
        "Richwood & Darst" : CLLocationCoordinate2DMake(39.633267, -79.933831),
        "The Domain Student Housing" : CLLocationCoordinate2DMake(39.653669, -79.999875),
        "The Villages at West Run" : CLLocationCoordinate2DMake(39.669403, -79.950789),
        "Colasante's Shelter" : CLLocationCoordinate2DMake(39.63404732, -79.97114227),
        "Sunset Beach" : CLLocationCoordinate2DMake(39.677717, -79.857742),
        "John Howard Motors" : CLLocationCoordinate2DMake(39.64462046, -79.92747163),
        "Rolling Hills" : CLLocationCoordinate2DMake(39.654575, -79.886328),
        "Cheat Lake Bridge" : CLLocationCoordinate2DMake(39.668275, -79.859206),
        "Advanced Auto Sabraton" : CLLocationCoordinate2DMake(39.627589, -79.929),
        "Metro Towers Apartments" : CLLocationCoordinate2DMake(39.644492, -79.957064),
        "College Park Apartments" : CLLocationCoordinate2DMake(39.636031, -79.945883)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        routes = [campusPM, downtownPM, green, orange, gold, red, tyrone, purple, cassville, blue, crown, mountainHeights, graftonRoad, pink, grey, westRun, westRunLate, blueAndGold, valleyView]
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return routes.count
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bus", for: indexPath) as! BusTableViewCell

        cell.name.text = self.routes[indexPath.row].name
        cell.semester.text = routes[indexPath.row].semesters
        cell.icon.image = UIImage(named: "Transportation")

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Bus services are provided by Mountain Line Transit Authority. For more information visit busride.org or call (304)291-7433."
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = LineViewController()
        vc.line = routes[indexPath.row]
        vc.coords = coords
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
