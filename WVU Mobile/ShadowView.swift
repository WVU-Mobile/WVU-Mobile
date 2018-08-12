//
//  ShadowView.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 12/27/16.
//  Copyright © 2016 WVU Mobile. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class ShadowView: UIView {
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBInspectable var cornerRadius: CGFloat = 0.0
    
    private var customBackgroundColor = UIColor.white
    
    override func draw(_ rect: CGRect) {
        customBackgroundColor.setFill()
        UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius ).fill()
    }
    
    override var backgroundColor: UIColor?{
        didSet {
            customBackgroundColor = backgroundColor!
            super.backgroundColor = UIColor.clear
        }
    }
    
    func setup() {
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3.0
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
