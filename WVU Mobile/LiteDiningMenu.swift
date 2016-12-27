//
//  LiteDiningMenu.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/23/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import UIKit

class LiteDiningMenu: UIView {
    @IBOutlet weak var diningHallName: UILabel!
    @IBOutlet weak var item1: UILabel!
    @IBOutlet weak var item2: UILabel!
    @IBOutlet weak var item3: UILabel!
    @IBOutlet weak var item4: UILabel!
    @IBOutlet weak var more: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    
    @IBInspectable var cornerRadius: CGFloat = 5.0
    
    private var customBackgroundColor = UIColor.white
    
    override func draw(_ rect: CGRect) {
        customBackgroundColor.setFill()
        UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius ).fill()
    }
    
    func press() {
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 3.0
    }
    
    
    override var backgroundColor: UIColor?{
        didSet {
            customBackgroundColor = backgroundColor!
            super.backgroundColor = UIColor.clear
        }
    }
    
    func setup() {
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.2
    }
    
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
            more.text = "& \(menu.count - 4) more"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

}
