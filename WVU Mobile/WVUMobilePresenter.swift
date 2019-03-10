//
//  WVUMobilePresenter.swift
//  WVU Mobile
//
//  Created by Kaitlyn Reneé Landmesser on 3/3/19.
//  Copyright © 2019 WVU Mobile. All rights reserved.
//

import UIKit

/// All the information needed to set up a tab bar.
protocol Tab {
    var viewController: UIViewController { get }
    var title: String { get }
    var icon: UIImage { get }
}

/// Confgiures the first page of the app.
class WVUMobilePresenter {
    
    /// Creates a tab bar controller with specified tabs.
    ///
    /// - Parameter tabs: An array of tabs to configure the tab bar with.
    /// - Returns: A tab bar controller configured with the specified tabs.
    class func createTabBarController(with tabs: [Tab]) -> UITabBarController {
        let tabBarController = UITabBarController()
        
        let controllers: [UIViewController] = tabs.enumerated().map { (index, tab) in
            let viewController = tab.viewController
            viewController.tabBarItem = UITabBarItem(title: tab.title,
                                                     image: tab.icon,
                                                     tag: index)
            return viewController
        }
        
        tabBarController.viewControllers = controllers.map { UINavigationController(rootViewController: $0) }
        
        tabBarController.tabBar.barTintColor = Colors.lightishBlue
        tabBarController.tabBar.tintColor = Colors.lightYellow
        tabBarController.tabBar.unselectedItemTintColor = .white

        return tabBarController
    }
    
}
