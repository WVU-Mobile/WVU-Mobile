//
//  Status.swift
//  WVU Mobile Networking
//
//  Created by Kaitlyn Landmesser on 12/4/24.
//

import Foundation

public enum Status: String, Codable {
    case normal = "1"
    case downBetween = "2"
    case down = "3"
    case downAll = "4"
    case free = "5"
    case downOne = "8"
    case closedSunday = "6"
    case closed = "7"
    case downMultiple = "10"
    case unknown
}
