//
//  RSSService.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/2/24.
//

import Foundation

/// Contains elements retrieved from URL containing XML data.
struct RSSElement: Hashable {
    var title: String
    var description: String
    var link: String 
    var date: Date
    
    var source: RSSService.NewsSource?
    var favorite: Bool = false
    
    var string: String {
        return "\(title) \(description) \(link)"
    }
    
    var identifier: String {
        return "\(date.rssDate)%%&\(title)%%&\(link)"
    }
    
    init(title: String, description: String, link: String, date: Date) {
        self.title = title
        self.description = description
        self.link = link
        self.date = date
    }
    
    init() {
        self.title = ""
        self.description = ""
        self.link = ""
        self.date = Date()
    }
}

/// Retrieves data from a specified source which follows the XML / RSS format.
class RSSService: NSObject, XMLParserDelegate {
    var elements =  [RSSElement]()
    var currentElement = RSSElement()
    
    var elementName = ""
    var parser = XMLParser()
    
    var source: NewsSource?
    
    func getNews(source: NewsSource, completion: ([RSSElement]) -> Void) {
        elements = []
        currentElement = RSSElement()
        self.source = source
        elementName = ""
                
        let url = URL(string: source.url)!
        
        parser = XMLParser(contentsOf: url)!
        
        parser.delegate = self
        parser.parse()

        completion(elements)
    }
    
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {
        if elementName == "item" {
            self.currentElement = RSSElement()
            self.currentElement.source = source
        }
        
        self.elementName = elementName
    }
    
    func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) {
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
                return "https://cal.wvu.edu/calendar.xml"
            }
        }
        
        var imageName: String {
            switch self {
            case .da:
                return "da"
            case .wvutoday, .events:
                return "wv"
            }
        }
    }
    
}
