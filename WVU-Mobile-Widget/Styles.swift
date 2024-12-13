//
//  Styles.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/7/24.
//

import SwiftUI

enum Styles {
    struct Colors {
        static let background = Color("background")
        static let text = Color("text")
    }
    
    struct Fonts {
        static let headline = Font.custom("AvenirNext-Bold", size: 25)
        static let headlineMedium = Font.custom("AvenirNext-Bold", size: 20)
        static let body = Font.custom("AvenirNext", size: 20)
        static let bodyStrong = Font.custom("AvenirNext-Medium", size: 15)
        static let subtitle = Font.custom("AvenirNext-Medium", size: 12)
    }

    struct ImageSize {
        static let small: CGFloat = 40
        static let large: CGFloat = 75
    }
    
    struct Image {
        static let prt = UIImage(imageLiteralResourceName: "prt")
    }
}

