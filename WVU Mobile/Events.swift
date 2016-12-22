//
//  Events.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser & Richard Deal on 3/9/15.
//  Copyright (c) 2015 WVUMobile. All rights reserved.
//

import UIKit
import Foundation

class Events: NSObject {
   /* var events = NSMutableArray()
    var days = 1
    
    var url: String {
        return "https://calendar.wvu.edu/page/rss/?duration=\(days)days"
    }
    override init() {
        super.init()
        pullRSS()
    }
    
    class var sharedInstance: Events{
        struct Static {
            static let instance : Events = Events()
        }
        return Static.instance
    }
    
    func pullRSS (){
        let nsURL = NSURL(string: url)!
        let parser: RSSParser = RSSParser().initWithURL(nsURL) as! RSSParser
        let feed = parser.feeds
        
        for i in 0 ..< feed.count {
            let fTitle: String = feed[i].objectForKey("title") as! String
            let fDescript: String = feed[i].objectForKey("description") as! String
            let fLink: String = feed[i].objectForKey("link") as! String
            let fDate: String = feed[i].objectForKey("pubDate") as! String
            
            let event = EventObject()
            event.title = fTitle
            event.link = fLink
            event.startDate = formatDate(fDate)
            event.descrip = fDescript
                        
            events.addObject(event)
        }
    }*/
}
