//
//  NavigationController.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/18/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.barTintColor = Colors.lightYellow
        self.navigationBar.tintColor = UIColor.black

        self.navigationBar.isOpaque = false
        self.navigationBar.isTranslucent = false
        self.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 24)!]
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }

}
