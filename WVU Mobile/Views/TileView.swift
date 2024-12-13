//
//  TileView.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 11/27/24.
//

import SwiftUI

/// A square view providing a link to another view and displaying a title.
struct TileView<T : View> : View {
    let title: String
    let view: T

    var body: some View {
        NavigationLink(destination: view,
                       label: {
            Text(title)
                .font(Styles.Fonts.bodyStrong)
                .padding()
                .frame(width: 150, height: 150)
                .background(Styles.Colors.accent)
                .cornerRadius(Styles.Constants.cornerRadius)
                .shadow(
                    color: Styles.Colors.shadow,
                    radius: Styles.Constants.cornerRadius)
                .foregroundColor(Styles.Colors.text2)
        })
    }
}
