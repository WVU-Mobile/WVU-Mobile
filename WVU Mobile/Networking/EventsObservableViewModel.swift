//
//  EventsObservableViewModel.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/3/24.
//

import Foundation

struct EventsViewModel: Hashable {
    let name: String
    let locationId: String
    let menuId: String
    
    var url: URL? {
        return URL(string: "https://menus.sodexomyway.com/BiteMenu/Menu?menuId=\(menuId)&locationId=\(locationId)&whereami=http://sandbox.sodexomyway.com/nau")
    }
}

class EventsObservableViewModel: ObservableObject {
    @Published var events = [RSSElement]()
    
    func fetch() {
        var events = [RSSElement]()
        let group = DispatchGroup()

        let request = RSSService()
        DispatchQueue.global().async(group: group) {
            request.getNews(source: .events, completion: { event in
                DispatchQueue.main.sync {
                    events += event
                }
            })
        }

        group.notify(queue: DispatchQueue.main) {
            events.sort(by: { $0.date.timeIntervalSince1970 > $1.date.timeIntervalSince1970 })
            self.events = events
        }
    }
}
