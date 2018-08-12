//
//  Menu.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/18/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import Foundation

class MenuRequest {
    class func getMenu(on date: Date, at diningHall: DiningHall, completion: (Menu?) -> Void) {
        let menu = Menu(diningHall: diningHall)
        
        guard let url = URL(string: diningHall.url(on: date)) else {
            completion(nil)
            return
        }
                
        do {
            let data = try Data(contentsOf: url)
            guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else { return }
                        
            let breakfastKeys = json.keys.filter({ $0.lowercased().contains("breakfast") })
            let lunchKeys = json.keys.filter({ $0.lowercased().contains("lunch") })
            let dinnerKeys = json.keys.filter({ $0.lowercased().contains("dinner") })
            
            for key in breakfastKeys {
                if let breakfast = json[key] as? String {
                    breakfast.removeTags.split(separator: "\n").forEach({ menu.breakfast.append(String($0)) })
                }
            }
            
            for key in lunchKeys {
                if let lunch = json[key] as? String {
                    lunch.removeTags.split(separator: "\n").forEach({ menu.lunch.append(String($0)) })
                }
            }
            
            for key in dinnerKeys {
                if let dinner = json[key] as? String {
                    dinner.removeTags.split(separator: "\n").forEach({ menu.dinner.append(String($0)) })
                }
            }
            
            completion(menu)
        } catch let error as NSError {
            completion(nil)
            print("Error: \(error)")
        }
    }
    
}
