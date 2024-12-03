//
//  StyleSheet.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/2/24.
//

import SwiftUI

enum Styles {
    struct Colors {
        static let background1 = Color("background")
        static let background2 = Color("background2")
        static let accent = Color("accent")
        static let accent2 = Color("accent2").opacity(0.4)
        static let accentBlue = Color("accentBlue")
        static let shadow = Color("shadow").opacity(0.2)
        static let text = Color("text")
        static let text2 = Color("text2")
    }
    
    struct Fonts {
        static let toolbar = Font.custom("AvenirNext-Bold", size: 30)
        static let headline = Font.custom("AvenirNext-Bold", size: 25)
        static let body = Font.custom("AvenirNext", size: 20)
        static let bodyStrong = Font.custom("AvenirNext-Medium", size: 20)
        static let subtitle = Font.custom("AvenirNext", size: 15)
        static let subtitleStrong = Font.custom("AvenirNext-Medium", size: 15)
    }
    
    struct Padding {
        static let paragraph: CGFloat = 5
    }
    
    struct Constants {
        static let cornerRadius: CGFloat = 10
    }
}

