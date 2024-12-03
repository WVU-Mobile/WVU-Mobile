//
//  PRTStatusService.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 11/15/22.
//

import Foundation

enum PRTStatus: String, Codable {
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

struct PRTModel: Codable {
    let status: PRTStatus
    let message: String
    let timestamp: String
    let bussesDispatched: String
}

struct PRTStatusService {
    private static var url: URL? {
        let timestamp = Int(Date().timeIntervalSince1970)
        let urlPath = "https://prtstatus.wvu.edu/api/\(timestamp)/?format=json"
        return URL(string: urlPath)
    }

    static func getStatus(completion: @escaping (PRTModel?, Error?) -> Void) {
        if let url = url {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                print(url.absoluteString)
                if let data = data, let prtModel = try? JSONDecoder().decode(PRTModel.self, from: data) {
                    completion(prtModel, error)
                } else {
                    completion(nil, error)
                }
            }

            task.resume()
        }
    }
}
