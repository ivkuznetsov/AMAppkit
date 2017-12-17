//
//  AMAlerBarView.swift
//  AMAppkit
//
//  Created by Ilya Kuznetsov on 11/26/17.
//  Copyright © 2017 Ilya Kuznetsov. All rights reserved.
//

import Foundation
import UIKit

open class AMAlertBarView: UIView {
    
    @IBOutlet private var textLabel: UILabel!
    
    open class func present(in view: UIView, message: String) -> Self {
        let barView = self.loadFromNib()
        view.addSubview(barView)
        barView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[barView]|", options: [], metrics: nil, views: ["barView":barView]))
        
        let next = view.next
        if let next = next as? UIViewController {
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[topLayoutGuide][barView]", options: [], metrics: nil, views: ["topLayoutGuide":next.topLayoutGuide, "barView":barView]))
        } else if next as? UIView != nil {
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[barView]", options: [], metrics: nil, views: ["barView":barView]))
        }
        
        barView.textLabel.text = message
        barView.alpha = 0
        barView.textLabel.superview?.transform = CGAffineTransform(translationX: 0, y: -barView.bounds.size.height)
        UIView.animate(withDuration: 0.25) {
            barView.textLabel.superview?.transform = CGAffineTransform.identity
            barView.alpha = 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            barView.hide()
        }
        return barView
    }
    
    open func message() -> String {
        return textLabel.text!
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        textLabel.superview?.layer.cornerRadius = 6.0
    }
    
    open func hide() {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0.0
        }) { (_) in
            self.removeFromSuperview()
        }
    }
}
