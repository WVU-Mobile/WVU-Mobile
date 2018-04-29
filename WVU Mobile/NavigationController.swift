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

        navigationBar.barTintColor = Colors.lightYellow
        navigationBar.tintColor = .black
        navigationBar.isOpaque = false
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue", size: 24) ?? UIFont.systemFont(ofSize: 24)]
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
    }

}
