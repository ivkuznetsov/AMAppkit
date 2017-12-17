//
//  AMOptionCell.swift
//  AMAppkit
//
//  Created by Ilya Kuznetsov on 12/8/17.
//  Copyright © 2017 Ilya Kuznetsov. All rights reserved.
//

import Foundation

class AMOptionCell: AMBaseTableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tintColor = textLabel?.tintColor
    }
}
