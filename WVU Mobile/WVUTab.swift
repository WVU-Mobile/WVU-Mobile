//
//  WVUTab.swift
//  WVU Mobile
//
//  Created by Kaitlyn Reneé Landmesser on 3/4/19.
//  Copyright © 2019 WVU Mobile. All rights reserved.
//

import UIKit

/// 
enum WVUTab: Tab {
    case campus
    case events
    case news
    case today
    case transit
    
    var viewController: UIViewController {
        switch self {
        case .campus:
            return CampusTableViewController.viewController
        case .events:
            return EventsViewController.viewController
        case .news:
            return TransitViewController.viewController
        case .today:
            return HomeViewController.viewController
        case .transit:
            return TransitViewController.viewController
        }
    }
    
    var title: String {
        switch self {
        case .campus:
            return "Campus"
        case .events:
            return "Events"
        case .news:
            return "News"
        case .today:
            return "Today"
        case .transit:
            return "Transit"
        }
    }
    
    var icon: UIImage {
        switch self {
        case .campus:
            return #imageLiteral(resourceName: "Navigation")
        case .events:
            return #imageLiteral(resourceName: "Event")
        case .news:
            return #imageLiteral(resourceName: "News")
        case .today:
            return #imageLiteral(resourceName: "Home")
        case .transit:
            return #imageLiteral(resourceName: "Transportation")
        }
    }
    
}
