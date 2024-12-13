//
//  DingingHallsView.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 11/16/22.
//

import SwiftUI

/// A view to present each dining hall with a link to the menu.
struct DingingHallsView: View {
    let staticDiningHalls: [DiningHallModel] = [
        DiningHallModel(name: "Cafe Evansdale", locationId: "34178001", menuId: "15274"),
        DiningHallModel(name: "Summit Cafe", locationId: "34178001", menuId: "35160"),
        DiningHallModel(name: "Hatfields", locationId: "34178001", menuId: "35161"),
        DiningHallModel(name: "Other Options", locationId: nil, menuId: nil)
    ]
    var body: some View {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Styles.Colors.background1, Styles.Colors.background2]),
                               startPoint: .top,
                               endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                ScrollView (.vertical, showsIndicators: true) {
                    VStack {
                        ForEach(staticDiningHalls, id: \.self) { model in
                            DiningHallDetailsView(model: model)
                        }
                    }.padding()
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Dining Halls")
                    .font(Styles.Fonts.toolbar)
                    .foregroundColor(Styles.Colors.text)
            }
        }
        .toolbarBackground(Styles.Colors.background1, for: .navigationBar)
    }
}

struct DiningHallModel: Hashable {
    let name: String
    let locationId: String?
    let menuId: String?
    
    var url: URL? {
        guard let locationId, let menuId else {
            return URL(string: "https://diningservices.wvu.edu/locations")
        }
        return URL(string: "https://menus.sodexomyway.com/BiteMenu/Menu?menuId=\(menuId)&locationId=\(locationId)&whereami=http://sandbox.sodexomyway.com/nau")
    }
}

struct DiningHallDetailsView: View {
    @State var showSafari = false
    
    var model: DiningHallModel
    var body: some View {
        VStack {
            Button {
                showSafari = true
            } label: {
                Text(model.name)
                    .font(Styles.Fonts.body)
                    .foregroundColor(Styles.Colors.text2)
                    .multilineTextAlignment(.leading)
            }
        }
        .padding()
        .background(Styles.Colors.accent)
        .cornerRadius(Styles.Constants.cornerRadius)
        .shadow(
            color: Styles.Colors.shadow,
            radius: Styles.Constants.cornerRadius
        )
        .frame(maxWidth: .infinity)
        .sheet(isPresented: self.$showSafari) {
            if let url = model.url {
                SafariView(url: url)
            } else {
                Text("Something went wrong.")
            }
        }

    }
}
