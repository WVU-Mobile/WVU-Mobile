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
            let json = try JSONSerialization.jsonObject(with: data, options:.mutableContainers) as! [[String:Any]]
            for j in json {
                if let name = j["item"] as? String {
                    if name.isEmpty {
                        continue
                    }
                    menu.menu.append(MenuItem(meal: j["meal"] as! String, name: name))
                }
            }
            
            completion(menu)
        }
        catch let error as NSError {
            print("Error: \(error)")
        }
    }
    
}
