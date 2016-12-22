//
//  NewsRSSParser.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser & Richard Deal on 3/3/15.
//  Copyright (c) 2015 WVUMobile. All rights reserved.
//

import Foundation

/*class RSSParser: NSObject, XMLParserDelegate {
    
    var parser = XMLParser()
    var feeds = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var ftitle = NSMutableString()
    var link = NSMutableString()
    var fdescription = NSMutableString()
    var fdate = NSMutableString()
    
    // Initialize parser
    func initWithURL(url :NSURL) -> AnyObject {
        startParse(url)
        return self
    }
    
    func startParse(url :NSURL) {
        feeds = []
        parser = XMLParser(contentsOfURL: url)!
        parser.delegate = self
        parser.shouldProcessNamespaces = false
        parser.shouldReportNamespacePrefixes = false
        parser.shouldResolveExternalEntities = false
        parser.parse()
    }
    
    func allFeeds() -> NSMutableArray {
        return feeds
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element = elementName
        
        if (element as NSString).isEqualToString("item") {
            elements = NSMutableDictionary()
            elements = [:]
            ftitle = NSMutableString()
            ftitle = ""
            link = NSMutableString()
            link = ""
            fdescription = NSMutableString()
            fdescription = ""
            fdate = NSMutableString()
            fdate = ""
        }
        
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if (elementName as NSString).isEqualToString("item") {
            if ftitle != "" {
                elements.setObject(ftitle, forKey: "title")
            }
            
            if link != "" {
                elements.setObject(link, forKey: "link")
            }
            
            if fdescription != "" {
                elements.setObject(fdescription, forKey: "description")
            }
            
            if fdate != "" {
                elements.setObject(fdate, forKey: "pubDate")
            }
            
            feeds.addObject(elements)
        }
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        if element.isEqualToString("title") {
            ftitle.appendString(string)
        } else if element.isEqualToString("link") {
            link.appendString(string)
        }else if element.isEqualToString("description") {
            fdescription.appendString(string)
        }else if element.isEqualToString("pubDate") {
            fdate.appendString(string)
        }
        
    }
    
    
}*/
