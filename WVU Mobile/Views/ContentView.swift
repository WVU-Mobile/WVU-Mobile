//
//  ContentView.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 11/11/22.
//

import SwiftUI
import UIKit

/// The main view of the app - contains PRT status, news snippet, and "More" section linking to the rest of the app content.
struct ContentView: View {
    @StateObject var prtViewModel = PRTService()
    @StateObject var newsViewModel = NewspaperService()

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Styles.Colors.background1, Styles.Colors.background2]),
                               startPoint: .top,
                               endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack {
                        PRTView(viewModel: prtViewModel)
                        NewsSnippetView(newsViewModel: newsViewModel)
                        MoreView()
                    }
                }
                .refreshable {
                    prtViewModel.fetch()
                    newsViewModel.fetch()
                }
            }
            .navigationBarTitle("")
        }
        .accentColor(Styles.Colors.text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension UIScrollView {
  open override var clipsToBounds: Bool {
    get { false }
    set { }
  }
}
