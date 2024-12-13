//
//  AboutView.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 11/19/24.
//

import SwiftUI

/// A view to present app info and contact information.
struct AboutView: View {
    var body: some View {
            ZStack {
                LinearGradient(gradient:
                                Gradient(colors: [Styles.Colors.background1,
                                                  Styles.Colors.background2]),
                               startPoint: .top,
                               endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                ScrollView (.vertical, showsIndicators: true) {
                    VStack {
                        Text("Hi friend. 👩🏽‍🚀")
                            .font(Styles.Fonts.headline)
                            .foregroundColor(Styles.Colors.text2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(Styles.Padding.paragraph)

                        Text("I developed this app in 2014 - 2015 school year as part of a senior design project (alongside co-creators Ricky, Jeremy, Corey, and Thomas). After 10 years - sitting here trying to update it - it's difficult for me to know what might be needed for students today. I see the PRT still breaks down regularly. I hope this update is useful to someone.")
                            .font(Styles.Fonts.body)
                            .foregroundColor(Styles.Colors.text2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(Styles.Padding.paragraph)

                        Text("This project is open source, on Github. If you have an interest or passion for updating it, shoot me an email (wvumobileapp@gmail.com). Even better, create a pull request.")
                            .font(Styles.Fonts.body)
                            .foregroundColor(Styles.Colors.text2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(Styles.Padding.paragraph)

                        Text("Cheers,")
                            .font(Styles.Fonts.body)
                            .foregroundColor(Styles.Colors.text2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(0)
                        Text("Kaitlyn")
                            .font(Styles.Fonts.body)
                            .foregroundColor(Styles.Colors.text2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer(minLength: 25)
                        Button(action: {
                            if let url = URL(string: "https://github.com/WVU-Mobile/WVU-Mobile") {
                                UIApplication.shared.open(url)
                            }
                            
                        }) {
                            HStack {
                                Image("github")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundStyle(.tint)
                                    .tint(.white)
                                Text("Code on Github")
                                    .font(Styles.Fonts.subtitle)
                            }
                        }
                        .padding(Styles.Padding.paragraph)
                        .background(Color("github"))
                        .cornerRadius(Styles.Constants.cornerRadius)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Styles.Colors.accent)
                    .cornerRadius(Styles.Constants.cornerRadius)
                    .shadow(color: Styles.Colors.shadow, radius: 10)
            }
                .padding()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("About")
                    .font(Styles.Fonts.toolbar)
                    .foregroundColor(Styles.Colors.text)
            }
        }
        .toolbarBackground(Styles.Colors.background1, for: .navigationBar)
    }
}
