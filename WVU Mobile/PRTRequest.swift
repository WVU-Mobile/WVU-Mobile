//
//  PRTRequest.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/23/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import Foundation

class PRTRequest {
    class func getPRTStatus(completion: (PRT?) -> Void) {
        
        let timestamp = Int(Date().timeIntervalSince1970)
        let urlPath: String = "https://prtstatus.wvu.edu/api/\(timestamp)/?format=json"
        print(urlPath)
        
        guard let url = URL(string: urlPath) else {
            completion(nil)
            return
        }
        
        do {
            let jsonData = try Data(contentsOf: url)
            
            if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? NSDictionary {
                guard let status = json["status"] as? String else {
                    completion(nil)
                    return
                }
                guard let message =  json["message"] as? String else {
                    completion(nil)
                    return
                }
                guard let time = json["timestamp"] as? String else {
                    completion(nil)
                    return
                }
                completion(PRT(status: Int(status)!, message: message, time: Int(time)!))
            }
        }
        catch let error as NSError {
            print("Error: \(error)")
        }
        
        completion(nil)
    }
}
