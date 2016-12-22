//
//  PRTView.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/22/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import UIKit

@IBDesignable class PRTView: UIView {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
}
