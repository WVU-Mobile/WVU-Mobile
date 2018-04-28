//
//  TabBarController.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/18/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.barTintColor = Colors.lightishBlue
        self.tabBar.tintColor = Colors.lightYellow
        if #available(iOS 10.0, *) {
            self.tabBar.unselectedItemTintColor = UIColor.white
        }
        
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12)], for: .normal)
    }

}
