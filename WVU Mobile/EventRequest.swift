//
//  WebRequest.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/22/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import Foundation

class EventRequest: NSObject, XMLParserDelegate {
    
    var events =  [Event]()
    var currentElement = Event()
    
    var elementName = ""
    let parser:XMLParser

    override init() {
        let urlString = "https://calendar.wvu.edu/page/rss/?duration=1days"
        
        let url = URL(string: urlString)!
        
        parser = XMLParser(contentsOf: url)!
        
        super.init()
        
        parser.delegate = self
        parser.parse()
        
        for e in events {
            print(e.title)
            print(e.description)
            print(e.link)
            print(e.date.rssPrint)
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        self.elementName = elementName
        
        if elementName == "item" {
            self.currentElement = Event()
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            self.events.append(currentElement)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch self.elementName {
        case "title":
            currentElement.title = string
        case "link":
            currentElement.link = string
        case "description":
            currentElement.description = string
        case "pubDate":
            currentElement.date = Date.rssDate(date: string) // todo
        default:
            return
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("Error parsing.")
    }
    
}
