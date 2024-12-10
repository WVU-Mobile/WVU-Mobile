//
//  PRTModel+TimelineEntry.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/7/24.
//
import WidgetKit
import PRTStatus

/// Extends PRTModel to support Widgets. 
extension PRTModel: @retroactive TimelineEntry {
    public var date: Date {
        guard let timeInterval = TimeInterval(timestamp) else {
            return Date()
        }
        return Date(timeIntervalSince1970: timeInterval)
    }
}
