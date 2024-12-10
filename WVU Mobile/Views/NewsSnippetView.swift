//
//  NewsSnippetView.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 11/27/24.
//

import SwiftUI

/// A collection of tiles which link to sections of the app.
struct NewsSnippetView: View {
    @StateObject var newsViewModel: NewspaperService

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("News")
                    .font(Styles.Fonts.headline)
                    .foregroundColor(Styles.Colors.text)
                Spacer()
                NavigationLink(destination: NewsDetailsView(viewModel: newsViewModel, showBody: true),
                               label: {
                    Text("View >")
                        .font(Styles.Fonts.bodyStrong)
                        .padding()
                        .foregroundColor(Styles.Colors.text)
                })
            }
            .accessibilityRepresentation(representation: {
                NavigationLink(destination: NewsDetailsView(viewModel: newsViewModel, showBody: true),
                               label: {
                    Text("News. View.")
                        .font(Styles.Fonts.bodyStrong)
                        .padding()
                        .foregroundColor(Styles.Colors.text)
                })
            })
            VStack {
                ForEach(newsViewModel.news.prefix(2), id: \.self) { news in
                    let newsModel = RSSModel(title: news.title,
                                              body: news.description,
                                              imageName: news.source?.imageName ?? "wv",
                                              urlString: news.link,
                                              date: news.date)                    
                    NavigationLink(destination: NewsDetailsView(viewModel: newsViewModel, showBody: true),
                                   label: {
                        NewsHeadlineView(newsModel: newsModel)
                    })
                }
            }
        }
        .padding()
        .onAppear {
            newsViewModel.fetch()
        }
    }
}

/// A view representing each headline item.
struct NewsHeadlineView: View {
    var newsModel: RSSModel
    var body: some View {
        HStack {
            Image(uiImage: UIImage(imageLiteralResourceName: newsModel.imageName))
                .resizable()
                .foregroundColor(Styles.Colors.accentBlue)
                .frame(width: 42, height: 42)
                .padding()
                .background(Styles.Colors.accent2)
                .cornerRadius(Styles.Constants.cornerRadius)
            VStack(alignment: .leading) {
                Text(newsModel.title)
                    .lineLimit(1)
                    .font(Styles.Fonts.bodyStrong)
                    .foregroundColor(Styles.Colors.text2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(newsModel.body)
                    .font(Styles.Fonts.subtitle)
                    .lineLimit(3)
                    .foregroundColor(Styles.Colors.text2)
                    .frame(maxWidth: .infinity, alignment: .leading)

            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .accessibilityRepresentation {
            Text("\(newsModel.title). \(newsModel.body). Tap for more news stories.")
        }
        .padding()
        .background(Styles.Colors.accent)
        .cornerRadius(Styles.Constants.cornerRadius)
        .shadow(
            color: Styles.Colors.shadow,
            radius: Styles.Constants.cornerRadius
        )
    }
}
