//
//  TabsCell.swift
//  YouPlayer
//
//  Created by Ilya Kuznetsov on 11/30/17.
//  Copyright © 2017 Ilya Kuznetsov. All rights reserved.
//

import Foundation

@objc open class TabsCell: UIView {
    
    public private(set) var tabsView: TabsView! {
        didSet {
            tabsView.translatesAutoresizingMaskIntoConstraints = false
            self.insertSubview(tabsView, at: 0)
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tabsView]|", options: [], metrics: nil, views: ["tabsView":tabsView]))
            self.addConstraint(NSLayoutConstraint(item: tabsView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        }
    }
    
    open class func make(titles: [String], action: @escaping (Int)->()) -> Self {
        let view = self.loadFromNib()
        view.tabsView = TabsView(titles: titles, style: .dark, didSelect: { (button) in
            action(button.tag)
        })
        return view
    }
}
