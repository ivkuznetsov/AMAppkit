//
//  AMNoObjectsView.swift
//  AMAppkit
//
//  Created by Ilya Kuznetsov on 11/26/17.
//  Copyright © 2017 Arello Mobile. All rights reserved.
//

import Foundation

open class AMNoObjectsView: UIView {
    
    @IBOutlet open var titleLabel: UILabel!
    @IBOutlet open var detailsLabel: UILabel!
    @IBOutlet open var actionButton: AMBorderedButton?
    @IBOutlet open var centerConstraint: NSLayoutConstraint?
    
    open var actionClosure: (()->())? {
        didSet {
            actionButton?.isHidden = actionClosure == nil
        }
    }
    
    @IBAction private func action(sender: UIButton) {
        actionClosure?()
    }
}
