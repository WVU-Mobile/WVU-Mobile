//
//  MoreView.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 11/29/24.
//

import SwiftUI

/// A collection of tiles which link to sections of the app.
struct MoreView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("More")
                .font(Styles.Fonts.headline)
                .foregroundColor(Styles.Colors.text)
            ScrollView (.horizontal, showsIndicators: false) {
                HStack {
                    TileView(
                        title: "Dining Halls",
                        view: DingingHallsView()
                    )
                    TileView(
                        title: "Events",
                        view: EventsView()
                    )
                    TileView(
                        title: "Emergency Resources",
                        view: EmergencyView()
                    )
                    TileView(
                        title: "About",
                        view: AboutView()
                    )
                }
            }
        }
        .padding()
    }
}
