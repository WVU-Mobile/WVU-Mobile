//
//  Style.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/18/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import UIKit

/// Specifies an app style.
protocol Style {
    var navigationBarStyle: NavigationBarStyle? { get set }
}

protocol NavigationBarStyle {
    var barTintColor: UIColor { get }
    var tintColor: UIColor { get }
    var isOpaque: Bool { get }
    var isTranslucent: Bool { get }
    var titleTextAttributes: [NSAttributedString.Key : Any]? { get }
    var shadowImage: UIImage { get }
    var defaultBackgroundImage: UIImage { get }
}

extension Style {
    func apply(to viewController: UIViewController) {
        apply(to: viewController.navigationController?.navigationBar)
    }
    
    func apply(to navigationBar: UINavigationBar?) {
        
        if let navigationBarStyle = navigationBarStyle {
            navigationBar?.barTintColor = navigationBarStyle.barTintColor
            navigationBar?.tintColor = navigationBarStyle.tintColor
            navigationBar?.isOpaque = navigationBarStyle.isOpaque
            navigationBar?.isTranslucent = navigationBarStyle.isTranslucent
            navigationBar?.titleTextAttributes = navigationBarStyle.titleTextAttributes
            navigationBar?.shadowImage = navigationBarStyle.shadowImage
            navigationBar?.setBackgroundImage(navigationBarStyle.defaultBackgroundImage, for: .default)
        }
    }

}

/// Allows customization and overriding of the app style at a view controller level. 
protocol Styleable {
    var style: Style? { get set }
    
    func applyStyle() 
}
