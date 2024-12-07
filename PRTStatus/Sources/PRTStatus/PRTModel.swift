//
//  PRT.swift
//  WVU Mobile Networking
//
//  Created by Kaitlyn Landmesser on 12/4/24.
//

import Foundation

public struct PRTModel: Codable {
    public let status: Status
    public let message: String
    public let timestamp: String
    public let bussesDispatched: String
    
    public init(status: Status,
                message: String,
                timestamp: String,
                bussesDispatched: String) {
        self.status = status
        self.message = message
        self.timestamp = timestamp
        self.bussesDispatched = bussesDispatched
    }
}
