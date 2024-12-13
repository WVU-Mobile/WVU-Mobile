//
//  WebRequest.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/22/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import Foundation

/// Retrieves news from both the WVU newspaper and the Daily Anthem. 
class NewspaperService: ObservableObject {
    @Published var news = [RSSElement]()
    
    func fetch() {
        var news = [RSSElement]()
        let group = DispatchGroup()

        let request = RSSService()
        DispatchQueue.global().async(group: group) {
            request.getNews(source: .wvutoday, completion: { wvuTodayNews in
                DispatchQueue.main.sync {
                    news += wvuTodayNews
                }
            })
        }

        let request2 = RSSService()
        DispatchQueue.global().async(group: group) {
            request2.getNews(source: .da, completion: { daNews in
                DispatchQueue.main.sync {
                    news += daNews
                }
            })
        }

        group.notify(queue: DispatchQueue.main) {
            news.sort(by: { $0.date.timeIntervalSince1970 > $1.date.timeIntervalSince1970 })
            self.news = news
        }
    }
}
