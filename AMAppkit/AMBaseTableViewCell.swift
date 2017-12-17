//
//  AMBaseTableViewCell.swift
//  AMAppkit
//
//  Created by Ilya Kuznetsov on 11/26/17.
//  Copyright © 2017 Ilya Kuznetsov. All rights reserved.
//

import Foundation

@objc public protocol TCellObjectHolding: NSObjectProtocol {
    
    var object: AnyHashable? { get set }
}

@objc public extension UITableViewCell {
    
    var separatorHidden: Bool {
        set {
            for view in findSeparatorViews() {
                view.isHidden = newValue
            }
        }
        get {
            return findSeparatorViews().first?.isHidden ?? true
        }
    }
    
    private func findSeparatorViews() -> [UIView] {
        var views: [UIView] = []
        
        for view in subviews {
            if String(describing: type(of: view)).contains("SeparatorView") {
                views.append(view)
            }
        }
        return views
    }
}

open class AMBaseTableViewCell: UITableViewCell, TCellObjectHolding {
    
    open var object: AnyHashable?
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.selectedBackgroundView = UIView()
        self.selectedBackgroundView?.backgroundColor = UIColor(white: 0.5, alpha: 0.1)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.separatorHidden = separatorHidden
    }
}
