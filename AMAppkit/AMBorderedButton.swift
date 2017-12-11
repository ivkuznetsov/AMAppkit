//
//  AMBorderedButton.swift
//  AMAppkit
//
//  Created by Ilya Kuznetsov on 12/5/17.
//  Copyright © 2017 Arello Mobile. All rights reserved.
//

import Foundation

@IBDesignable open class AMBorderedButton: AMFadeButton {
    
    @IBInspectable open var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
    }
    @IBInspectable open var onScreenPixelWidth: Bool = true {
        didSet {
            reloadBorder()
        }
    }
    @IBInspectable open var borderWidth: CGFloat = 0 {
        didSet {
            reloadBorder()
        }
    }
    @IBInspectable open var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        reloadBorder()
        defer {
            borderColor = titleColor(for: .normal)
        }
    }
    
    private func reloadBorder() {
        if onScreenPixelWidth {
            layer.borderWidth = 1.0 / UIScreen.main.scale
        } else {
            layer.borderWidth = borderWidth
        }
    }
}
