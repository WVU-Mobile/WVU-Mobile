//
//  LightStyle.swift
//  WVU Mobile
//
//  Created by Kaitlyn Reneé Landmesser on 3/5/19.
//  Copyright © 2019 WVU Mobile. All rights reserved.
//

import UIKit

/// An airy, pastel, color scheme for the application. AKA "Light Mode".
struct LightStyle: Style {
    var navigationBarStyle: NavigationBarStyle? = LightNavigationBarStyle()
    
}

struct LightNavigationBarStyle: NavigationBarStyle {
    var barTintColor = Colors.lightYellow
    var tintColor = UIColor.black
    var isOpaque = false
    var isTranslucent = false
    var titleTextAttributes: [NSAttributedString.Key : Any]? = [.font: UIFont(name: "HelveticaNeue", size: 24) ?? .systemFont(ofSize: 24)]
    var shadowImage = UIImage()
    var defaultBackgroundImage = UIImage()

}
