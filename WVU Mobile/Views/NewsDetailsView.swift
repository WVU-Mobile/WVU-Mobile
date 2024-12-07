//
//  NewsDetailsView.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 11/16/22.
//

import SwiftUI
import SafariServices

/// A view which shows every news article published in the past 90 days from the DA and WVU News.
struct NewsDetailsView: View {
    @StateObject var viewModel: NewspaperService
    var showBody: Bool
    
    var body: some View {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Styles.Colors.background1, Styles.Colors.background2]),
                               startPoint: .top,
                               endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                ScrollView (.vertical, showsIndicators: true) {
                    VStack {
                        ForEach(viewModel.news, id: \.self) { news in
                            let newsModel = RSSModel(title: news.title,
                                                      body: news.description,
                                                      imageName: news.source?.imageName ?? "wv",
                                                      urlString: news.link,
                                                      date: news.date)
                            NewsHeadlineDetailsView(newsModel: newsModel, showBody: showBody)
                        }
                    }.padding()
                    .onAppear {
                        viewModel.fetch()
                    }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("News")
                    .font(.custom("AvenirNext-Bold", size: 30))
                    .foregroundColor(Styles.Colors.text)
            }
        }
        .toolbarBackground(Styles.Colors.background1, for: .navigationBar)
    }
}

/// A single news headline, showcasing the first snippet of text, title, and image.
struct NewsHeadlineDetailsView: View {
    @State var showSafari = false
    var newsModel: RSSModel
    var showBody: Bool

    var body: some View {
        VStack {
            HStack {
                Image(uiImage: UIImage(imageLiteralResourceName: newsModel.imageName))
                    .resizable()
                    .foregroundColor(Styles.Colors.text2)
                    .frame(width: 20, height: 20)
                Spacer()
                Text("\(newsModel.date.hourPrint), \(newsModel.date.day)")
                    .lineLimit(2)
                    .font(Styles.Fonts.subtitle)
                    .foregroundColor(Styles.Colors.text2)
            
            }
            Text(newsModel.title)
                .font(Styles.Fonts.headline)
                .foregroundColor(Styles.Colors.text2)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            if showBody {
                Text(newsModel.body)
                    .font(Styles.Fonts.body)
                    .foregroundColor(Styles.Colors.text2)
                    .frame(maxWidth: .infinity, alignment: .leading)
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
        .onTapGesture {
            self.showSafari = true
        }
        .sheet(isPresented: self.$showSafari) {
            if let url = URL(string: newsModel.urlString) {
                SafariView(url: url)
            } else {
                Text("Something went wrong.")
            }
        }

    }
}

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }

}
