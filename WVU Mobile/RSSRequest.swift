//
//  WebRequest.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/22/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import Foundation

class RSSRequest: NSObject, XMLParserDelegate {
    var elements =  [RSSElement]()
    var currentElement = RSSElement()
    
    var elementName = ""
    var parser = XMLParser()
    
    var source: NewsSource?
    
    func getEvents(days: Int, completion: ([RSSElement]) -> Void) {
        elements = []
        currentElement = RSSElement()
        elementName = ""
        
        let urlString = "https://calendar.wvu.edu/page/rss/?duration=\(days)days"
        let url = URL(string: urlString)!
        
        parser = XMLParser(contentsOf: url)!
        
        parser.delegate = self
        parser.parse()
        
        completion(elements)

    }
    
    func getNews(source: NewsSource, completion: ([RSSElement]) -> Void) {
        elements = [RSSElement]()
        currentElement = RSSElement()
        self.source = source
        elementName = ""
                
        let url = URL(string: source.url)!
        
        parser = XMLParser(contentsOf: url)!
        
        parser.delegate = self
        parser.parse()

        completion(elements)
        
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "item" {
            self.currentElement = RSSElement()
            self.currentElement.source = source
        }
        
        self.elementName = elementName
        
        if elementName == "enclosure" {
            guard let url = attributeDict["url"] else {
                return
            }

            self.currentElement.image = RSSElement.Image.init(url: url)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" && !currentElement.description.isEmpty {
            self.elements.append(currentElement)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return
        }

        let string = string.replacingOccurrences(of: "<[^>]+>", with: " ", options: .regularExpression, range: nil)
        let t = string.trimmingCharacters(in: .whitespacesAndNewlines)
        let text = t.replacingOccurrences(of: "\n", with: " ")

        switch self.elementName {
        case "title":
            currentElement.title += text
        case "link":
            currentElement.link += text
        case "description":
            currentElement.description += text
        case "pubDate":
            currentElement.date = Date.rssDate(date: string)
        case "guid":
            currentElement.guid += text
        default:
            return
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("Error parsing.")
    }
    
    enum NewsSource {
        case da, wvutoday, events
        
        var name: String {
            switch self {
            case .da:
                return "Daily Athenaeum"
            case .wvutoday:
                return "WVU Today"
            case .events:
                return "Events"
            }
        }
        
        var url: String {
            switch self {
            case .da:
                return "https://www.thedaonline.com/search/?f=rss"
            case .wvutoday:
                return "https://wvutoday.wvu.edu/stories.rss"
            case .events:
                return "Events"
            }
        }
        
        var image: String {
            switch self {
            case .da:
                return "DA"
            case .wvutoday, .events:
                return "FlyingWV"
            }
        }
    }
    
}
