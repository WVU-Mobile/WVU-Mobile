//
//  PRTStatus.swift
//  WVU Mobile
//
//  Created by Richard Deal on 12/17/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import Foundation

class PRTStatus{

    var status: Int
    var message: String
    var time: Date
    
    init(status: Int, message: String, time: Int) {
        self.status = status
        self.message = message
        self.time = Date(timeIntervalSince1970: TimeInterval(time))
    }

}

