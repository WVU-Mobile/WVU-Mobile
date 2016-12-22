//
//  Event.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/22/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import Foundation

class Event {
    var title: String
    var description: String
    var link: String // possible URL? 
    var guid: String // no idea what this is
    var date: Date
    
    init(title: String, description: String, link: String, guid: String, date: Date) {
        self.title = title
        self.description = description
        self.link = link
        self.guid = guid
        self.date = date
    }
    
    init() {
        self.title = ""
        self.description = ""
        self.link = ""
        self.guid = ""
        self.date = Date()
    }
}
