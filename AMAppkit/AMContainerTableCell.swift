//
//  AMContainerTableCell.swift
//  AMAppkit
//
//  Created by Ilya Kuznetsov on 12/27/17.
//

import Foundation
import UIKit

open class AMContainerTableCell: AMBaseTableViewCell {
    
    override open func prepareForReuse() {
        super.prepareForReuse()
        self.contentView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    func attach(view: UIView) {
        backgroundColor = UIColor.clear
        selectionStyle = .none
        view.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
        contentView.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: ["view":view]))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: ["view":view]))
    }
    
    func attachWithoutConstraint(view: UIView) {
        backgroundColor = UIColor.clear
        selectionStyle = .none
        view.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
        contentView.addSubview(view)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
