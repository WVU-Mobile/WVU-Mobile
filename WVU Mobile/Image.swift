//
//  Image.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/28/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import UIKit

extension UIImage{
    
    func alpha(value:CGFloat)->UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
        
    }
}
