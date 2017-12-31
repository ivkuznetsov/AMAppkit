//
//  TabsViewButton.swift
//  YouPlayer
//
//  Created by Ilya Kuznetsov on 11/30/17.
//  Copyright © 2017 Ilya Kuznetsov. All rights reserved.
//

import Foundation

@objc open class TabsViewButton: UIButton {
    
    open var badgeColor: UIColor = UIColor.red {
        didSet {
            setNeedsDisplay()
        }
    }
    
    open var showBadge: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if showBadge {
            let badgeWidth: CGFloat = 6.0
            
            badgeColor.setFill()
            UIBezierPath(roundedRect: CGRect(x: self.titleLabel!.x - 5 - badgeWidth, y: self.height / 2.0 - badgeWidth / 2.0 + 1, width: badgeWidth, height: badgeWidth), cornerRadius: badgeWidth / 2.0).fill()
        }
    }
}
