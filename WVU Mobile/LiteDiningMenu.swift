//
//  LiteDiningMenu.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/23/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import UIKit

class LiteDiningMenu: ShadowView {
    @IBOutlet weak var diningHallName: UILabel!
    @IBOutlet weak var item1: UILabel!
    @IBOutlet weak var item2: UILabel!
    @IBOutlet weak var item3: UILabel!
    @IBOutlet weak var item4: UILabel!
    @IBOutlet weak var more: UILabel!
    
    func setMenu(menu: Menu, meal: Menu.Meal) {
        diningHallName.text = menu.diningHall.name
        let labels = [item1, item2, item3, item4]
        let menu = menu.getMeal(meal: meal)
        
        if menu.isEmpty {
            item1.text = "Closed."
            return
        }
        
        for i in 0...(menu.count) {
            if i > 3 {
                break
            }
            labels[i]?.text = menu[i].name
        }
        
        if menu.count > 4 {
            more.text = "+ \(menu.count - 4) more >>"
        } else {
            more.text = "more >>"
        }
    }
}
